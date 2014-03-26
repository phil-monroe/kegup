require 'spec_helper'

describe OrgsController, :focus do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns orgs" do
      org1 = create(:org)
      org2 = create(:org)
      get :index
      expect(assigns(:orgs)).to eq([org2, org1])
    end
  end


  describe "GET show" do
    before(:each) do
      @org = create(:org)
      get :show, id: @org.id
    end

    it "returns the selected org" do
      expect(assigns(:org)).to eq(@org)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end


  describe "POST create" do
    let(:org_hash) { attributes_for(:org).stringify_keys }

    it "creates an org" do
      post :create, org: org_hash
      expect(Org.count).to be(1)
      expect(Org.first.attributes).to include(org_hash)
      expect(response).to redirect_to(Org.first)
    end
  end


  describe "PATCH update" do
    it "updates an org" do
      org = create(:org)
      new_name = "test org name"
      patch :update, id: org.id, org: { name: new_name }
      org.reload
      expect(org.name).to eq(new_name)
    end
  end


  describe "DELETE destroy" do
    it "removes an org" do
      org = create(:org)
      delete :destroy, id: org.id
      expect { Org.find(org.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
