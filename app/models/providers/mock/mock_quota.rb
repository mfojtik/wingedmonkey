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

module Providers
  module Mock
    class MockQuota < Quota

      def self.all filter=nil
        quotas = []
        connect! do |connection|
          quotas << Quota
            .create({
                      :id => "application",
                      :name => _("Applications"),
                      :usage => connection.application_count,
                      :limit => connection.max_application_count,
                      :unit => _("applications"),
                    })
        end
      end

      def self.find(id)
        self.all.find{|quota| quota.id.to_s == id}
      end

    end
  end
end
