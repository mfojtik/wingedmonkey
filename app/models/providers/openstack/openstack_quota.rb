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
  module OpenStack
    class OpenStackQuota < Quota

      def self.all filter=nil
        quotas = []
        connect! do |connection|
          quotas_hash = connection.limits[:absolute]
          quotas << Quota.
            create({
                     :id => "instance",
                     :name => _("Instances"),
                     :usage => quotas_hash[:totalInstancesUsed],
                     :limit => quotas_hash[:maxTotalInstances],
                     :unit => _("instances"),
                   })
          quotas << Quota.
            create({
                     :id => "vcpu",
                     :name => _("VCPUs"),
                     :usage => quotas_hash[:totalCoresUsed],
                     :limit => quotas_hash[:maxTotalCores],
                     :unit => _("VCPUs"),
                   })
          quotas << Quota.
            create({
                     :id => "memory",
                     :name => _("RAM"),
                     :usage => quotas_hash[:totalRAMUsed],
                     :limit => quotas_hash[:maxTotalRAMSize],
                     :unit => _("MB"),
                   })
        end
      end

      def self.find(id)
        self.all.find{|quota| quota.id.to_s == id}
      end

    end
  end
end
