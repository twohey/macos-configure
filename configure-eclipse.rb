#!/usr/bin/env ruby
# Copyright (C) 2012-2017 Paul Twohey. All Rights reserved. See LICENSE file

require 'English'
require 'net/http'
require 'rexml/document'
require 'shellwords'
require './util'
require './eclipse-plugins'


# Given a list of plugins, return a list of plugins which
# are already installed in eclipse/eclipse.
def filter_installed_plugins(eclipse_bin_path, plugins)
   out = run_and_check_err("#{eclipse_bin_path.shellescape} -nosplash -application org.eclipse.equinox.p2.director -listInstalledRoots")
  # There are two types of plugins listed, just names, or names with versions
  missing = plugins.clone
  out.lines.each do |line|
    next if line.start_with? "Operation completed"
    plugins.each do |package|
      pkg = package[:pkg]
      missing.delete(package) if line.start_with? pkg
    end
  end

  return missing
end

# Install the plugins we want. To make matters simpler, the plugins are
# installed one at a time, and are tagged between each installation in
# order to provide some measure of debuggability if (when) things go wrong.
def install_plugins(eclipse_bin_path, plugins)
  log("Installing #{plugins.size} plugins")
  plugins.each { |p| puts "* #{p[:pkg]} from #{p[:url]}" }

  log("Checking existing plugins")
  not_installed = filter_installed_plugins(eclipse_bin_path, plugins)
  log("#{plugins.size - not_installed.size} plugins installed. Installing remaining #{not_installed.size}")

  not_installed.each do |package|
    pkg = package[:pkg]
    url = package[:url]
    log("Installing #{pkg} from #{url}")
    human_name = pkg.split('/').first
    cmd = <<END
#{eclipse_bin_path.shellescape} -nosplash -application org.eclipse.equinox.p2.director \
 -repository '#{url}' \
 -installIU '#{pkg}' \
 -tag #{human_name}
END
    out = run_and_check_err(cmd)
    puts out
    still_not_installed = filter_installed_plugins(eclipse_bin_path, [ package ])
    if still_not_installed.size > 0 then
      fatal("#{package[:pkg]} did not install correctly")
    end
  end
end

# In typical eclipse fashion, they made a step forward with the Eclipse
# Marketplace, but also took a step back in that there is no easy way to
# script such installations. Instead what we do is use the Marketplace
# API to get the information to then drive an equinox install
def get_plugins_from_marketplace(marketplace_id, human_name)
  log("resolving #{human_name}: marketplace ID #{marketplace_id}")
  uri = URI("http://marketplace.eclipse.org/node/#{marketplace_id}/api/p")
  response = Net::HTTP.get_response(uri)
  check_net_err(response, "cannot fetch marketplace data for #{marketplace_id}")
  doc = REXML::Document.new(response.body)
  update_url = REXML::XPath.match(doc, '//updateurl').first.text
  log("  update url: #{update_url}")
  packages = []
  items = REXML::XPath.match(doc, '//ius/iu')
  items.each do |iu|
    pkg = iu.text + ".feature.group"
    log("  package   : #{pkg}")
    packages << { pkg: pkg, url: update_url }
  end
  return packages
end


###
### Run installing the plugins
###

# find the eclipse to work on.
# FIXME: right now just hack this to be what the other script installs
ECLIPSE_BIN_PATH = "/Applications/Eclipse JEE.app/Contents/MacOS/eclipse"
plugins = []
plugins += PLUGINS

# take marketplace items and resolve them to packages
puts "*** Resolving #{MARKETPLACE_PLUGINS.size} Marketplace items to packages"
MARKETPLACE_PLUGINS.each do |m|
  to_add = get_plugins_from_marketplace(m[:id], m[:human])
  plugins += to_add
end

install_plugins(ECLIPSE_BIN_PATH, plugins)

log(" Eclipse Configure Done")
