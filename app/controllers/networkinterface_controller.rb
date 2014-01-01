class NetworkinterfaceController < ApplicationController

  # GET /link/networkinterface/:id
  def show
    @networkinterface = backend_instance.compute_get_network(params[:id])

    if @networkinterface
      respond_with(@networkinterface)
    else
      respond_with(Occi::Collection.new, status: 404)
    end
  end

  # POST /link/networkinterface/
  def create
    networkinterface = request_occi_collection.links.first
    networkinterface_location = backend_instance.compute_attach_network(networkinterface)

    respond_with("/link/networkinterface/#{networkinterface_location}", status: 201, flag: :link_only)
  end

  # DELETE /link/networkinterface/:id
  def delete
    result = backend_instance.compute_detach_network(params[:id])

    if result
      respond_with(Occi::Collection.new)
    else
      respond_with(Occi::Collection.new, status: 304)
    end
  end
end
