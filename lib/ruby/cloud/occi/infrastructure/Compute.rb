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
# Description: OCCI Infrastructure Compute
# Author(s): Hayati Bice, Florian Feldhaus, Piotr Kasprzak
##############################################################################

require 'occi/core/Action'
require 'occi/core/Kind'
require 'occi/core/Resource'

module OCCI
  module Infrastructure
    class Compute < OCCI::Core::Resource
 
      # Define appropriate kind
      begin
          # Define actions
          actions = []
          actions << OCCI::Core::Action.new(scheme = "http://schemas.ogf.org/occi/infrastructure/compute/action#", term = "restart",
                      title = "Compute Action Restart",   attributes = ["graceful", "warm", "cold"])

          actions << OCCI::Core::Action.new(scheme = "http://schemas.ogf.org/occi/infrastructure/compute/action#", term = "start",
                      title = "Compute Action Start",     attributes = [])

          actions << OCCI::Core::Action.new(scheme = "http://schemas.ogf.org/occi/infrastructure/compute/action#", term = "stop",      
                     title = "Compute Action Stop",      attributes = ["graceful", "acpioff", "poweroff"])

          actions << OCCI::Core::Action.new(scheme = "http://schemas.ogf.org/occi/infrastructure/compute/action#", term = "suspend",#
                     title = "Compute Action Suspend",   attributes = ["hibernate", "suspend"])

          related = [OCCI::Core::Resource::KIND]
          entity_type = self
          entities = []

          term    = "compute"
          scheme  = "http://schemas.ogf.org/occi/infrastructure#"
          title   = "Compute Resource"

          attributes = OCCI::Core::Attributes.new()
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.cores',        mutable = true,   mandatory = false,  unique = true)
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.architecture', mutable = true,   mandatory = false,  unique = true)
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.state',        mutable = false,  mandatory = true,   unique = true)
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.hostname',     mutable = true,   mandatory = false,  unique = true)
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.memory',       mutable = true,   mandatory = false,  unique = true)
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.speed',        mutable = true,   mandatory = false,  unique = true)
          attributes << OCCI::Core::Attribute.new(name = 'occi.compute.id',           mutable = true,   mandatory = false,  unique = true)
          
          KIND = OCCI::Core::Kind.new(actions, related, entity_type, entities, term, scheme, title, attributes)
      end
 
      def initialize(attributes)
        super(attributes)
        @kind_type = "http://schemas.ogf.org/occi/infrastructure#compute"
      end

      def deploy()
        $backend.create_compute_instance(self)
      end
      
      def delete()
        $backend.delete_compute_instance(self)
        delete_entity()
      end

    end
  end
end