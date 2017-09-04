# Copyright (C) 2012-2017 Paul Twohey. All Rights reserved. See LICENSE file
# Holds the eclipse plugins to install

MARKETPLACE_PLUGINS = []
MARKETPLACE_PLUGINS << { id: 2706327, human: 'Docker Tooling' }
MARKETPLACE_PLUGINS << { id: 1216155, human: 'm2e apt' }
MARKETPLACE_PLUGINS << { id: 264, human: 'ECL Emma' }
MARKETPLACE_PLUGINS << { id: 1099, human: 'FindBugs' }
MARKETPLACE_PLUGINS << { id: 150, human: 'CheckStyle' }

# traditional plugins to install. 
PLUGINS = []
PLUGINS << { pkg: 'AnyEditTools.feature.group', url: 'http://andrei.gmxhome.de/eclipse/' }
PLUGINS << { pkg: 'ch.acanda.eclipse.pmd.feature.feature.group', url: 'http://www.acanda.ch/eclipse-pmd/release/latest' }
PLUGINS << { pkg: 'org.testng.eclipse.feature.group', url: 'http://beust.com/eclipse' }
PLUGINS << { pkg: 'org.testng.eclipse.maven.feature.feature.group', url: 'http://beust.com/eclipse' }
