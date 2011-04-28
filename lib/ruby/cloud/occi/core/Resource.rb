##############################################################################
#  Copyright 2011 Service Computing group, TU Dortmund
#  
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#  
#      http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
##############################################################################

##############################################################################
# Description: OCCI Core Resource
# Author(s): Hayati Bice, Florian Feldhaus, Piotr Kasprzak
##############################################################################

require 'occi/core/Entity'
require 'occi/core/Kind'

module OCCI
  module Core
    class Resource < Entity

      begin
        actions     = []
        related     = [OCCI::Core::Entity::KIND]
        entity_type = self
        entities    = []

        term    = "resource"
        scheme  = "http://schemas.ogf.org/occi/core#"
        title   = "Resource"

        attributes = OCCI::Core::Attributes.new()
        attributes << OCCI::Core::Attribute.new(name = 'occi.core.summary', mutable = true, mandatory = false, unique = true)
        attributes << OCCI::Core::Attribute.new(name = 'links',             mutable = true, mandatory = false, unique = false)
          
        KIND = OCCI::Core::Kind.new(actions, related, entity_type, entities, term, scheme, title, attributes)        
      end

      def initialize(attributes)
        attributes['occi.core.summary'] = "" if attributes['occi.core.summary'] == nil
        attributes['links']             = []
        super(attributes)
        @kind_type = "http://schemas.ogf.org/occi/core#resource"
      end

    end
  end
end