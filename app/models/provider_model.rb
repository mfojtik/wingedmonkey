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

module ProviderModel
  def connect!
    connection = Provider.current.connect!
    if block_given?
      yield connection
    else
      return connection
    end
  end

  def provider_model
    provider_type = Provider.current.type.camelize
    class_name = provider_type + self.name
    provider_module = Providers.const_get(provider_type)
    if provider_module.const_defined?(class_name) &&
        provider_module.const_get(class_name).class == Class
      provider_module.const_get(class_name)
    else
      nil
    end
  end

  def all
    provider_model.nil? ? nil :
      provider_model.all
  end

  def find id
    provider_model.nil? ? nil :
      (provider_model.find id)
  end

  def create attributes
    provider_model.nil? ? nil :
      (provider_model.new attributes)
  end

end
