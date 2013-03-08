# Copyright 2012-2013 Red Hat, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

module Providers::Mock
  # The connection object for a mock provider
  # Meant to immitate a connection to a real provider's API
  # This should not be copied for other provider implementations
  require_relative 'mock_launchable'
  class MockConnection
    @@provider_applications = []
    @@id = 1

    MOCK_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "mock", "config.yml"))
    MOCK_LAUNCHABLE_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "mock", "launchables.yml"))

    def launchables
      MOCK_LAUNCHABLE_CONFIG
    end

    def applications
      @@provider_applications
    end

    def add_application(application)
      if application_count >= max_application_count
        raise _("Application limit for mock provider reached.")
      else
        application.id = @@id
        @@id += 1
        @@provider_applications << application
      end
    end

    def destroy_application(application)
      @@provider_applications.delete(application)
    end

    def application_count
      applications.count
    end

    def max_application_count
      MOCK_CONFIG[:max_applications]
    end
  end
end
