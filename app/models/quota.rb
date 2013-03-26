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

require 'yaml'

class Quota
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ProviderModel
  extend ActiveModel::Naming

  #more to be added as needed
  attr_accessor :id, :name, :usage, :limit, :unit

  QUOTA_STATUS_OKAY = ""
  QUOTA_STATUS_WARNING = "warning"
  QUOTA_STATUS_DANGER = "danger"

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def status
    percent_usage = usage / limit
    case
      when percent_usage >= 0.9 then Quota::QUOTA_STATUS_DANGER
      when percent_usage >= 0.75 then Quota::QUOTA_STATUS_WARNING
      else Quota::QUOTA_STATUS_OKAY
    end
  end
end
