# Copyright (C) 2017 Paul Twohey. All Rights reserved. See LICENSE file
require 'net/http'
require 'English'

def log(msg)
  puts "** #{msg}"
end

def fatal(msg)
  $stderr.puts "ERROR #{msg}"
  $stderr.flush
  exit 1
end

def check_net_err(response, msg)
  return if response.is_a? Net::HTTPSuccess
  fatal(msg)
end

def run_and_check_err(cmd)
  out = `#{cmd}`
  return out if $CHILD_STATUS.success?
  $stderr.puts "*** ERROR Command execution failed"
  $stderr.puts "Command: #{cmd}"
  $stderr.puts " Exited: #{$CHILD_STATUS.exitstatus}"
  $stderr.flush
  exit 1
end
