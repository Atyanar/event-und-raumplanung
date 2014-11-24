require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe GroupsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Group. As you add validations to Group, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GroupsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context "when user is logged-in" do
    let(:user) { create :user }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET index" do
      it "assigns all groups as @groups" do
        group = Group.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:groups)).to eq([group])
      end
    end

    describe "GET show" do
      it "assigns the requested group as @group" do
        group = Group.create! valid_attributes
        get :show, {:id => group.to_param}, valid_session
        expect(assigns(:group)).to eq(group)
      end
    end

    describe "GET new" do
      it "assigns a new group as @group" do
        get :new, {}, valid_session
        expect(assigns(:group)).to be_a_new(Group)
      end
    end

    describe "GET edit" do
      it "assigns the requested group as @group" do
        group = Group.create! valid_attributes
        get :edit, {:id => group.to_param}, valid_session
        expect(assigns(:group)).to eq(group)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Group" do
          expect {
            post :create, {:group => valid_attributes}, valid_session
          }.to change(Group, :count).by(1)
        end

        it "assigns a newly created group as @group" do
          post :create, {:group => valid_attributes}, valid_session
          expect(assigns(:group)).to be_a(Group)
          expect(assigns(:group)).to be_persisted
        end

        it "redirects to the created group" do
          post :create, {:group => valid_attributes}, valid_session
          expect(response).to redirect_to(Group.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved group as @group" do
          post :create, {:group => invalid_attributes}, valid_session
          expect(assigns(:group)).to be_a_new(Group)
        end

        it "re-renders the 'new' template" do
          post :create, {:group => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested group" do
          group = Group.create! valid_attributes
          put :update, {:id => group.to_param, :group => new_attributes}, valid_session
          group.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested group as @group" do
          group = Group.create! valid_attributes
          put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
          expect(assigns(:group)).to eq(group)
        end

        it "redirects to the group" do
          group = Group.create! valid_attributes
          put :update, {:id => group.to_param, :group => valid_attributes}, valid_session
          expect(response).to redirect_to(group)
        end
      end

      describe "with invalid params" do
        it "assigns the group as @group" do
          group = Group.create! valid_attributes
          put :update, {:id => group.to_param, :group => invalid_attributes}, valid_session
          expect(assigns(:group)).to eq(group)
        end

        it "re-renders the 'edit' template" do
          group = Group.create! valid_attributes
          put :update, {:id => group.to_param, :group => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested group" do
        group = Group.create! valid_attributes
        expect {
          delete :destroy, {:id => group.to_param}, valid_session
        }.to change(Group, :count).by(-1)
      end

      it "redirects to the groups list" do
        group = Group.create! valid_attributes
        delete :destroy, {:id => group.to_param}, valid_session
        expect(response).to redirect_to(groups_url)
      end
    end
  end

  describe "in group room management" do
    let(:group1) { create :group, name: "group1"}
    let(:group2) { create :group, name: "group2"}
    let(:room1) { create :room}
    let(:room2) { create :room }

    # group1 = create(:group, name: "Group1")
    # group2 = create(:group, name: "Group2")
    # room1 = create(:room)
    # room2 = create(:room)

    describe "assigning a room" do

      context "that is already assigned" do
        before(:each) do
          get :assign_room, {:id => group2, :room => room1.to_param}, valid_session
        end
        # it "does not assign a room" do
        #   get :assign_room, {:id => group1.to_param, :room_id => room1.to_param}, valid_session
        #   # get :assign_room, {:id => group1.to_param, :room_id => room1.to_param}, valid_session
        #   expect(room1.group).to eq (group2.id)
        # end
      end

      context "that is not assigned yet" do
        it "assigns the room" do
          # puts group1.inspect
          # room1.group = group1
          get :assign_room, {:id => group1.to_param, :room_id => room1.to_param}, valid_session
          # puts group1.reload.inspect
          # puts Room.find(room1.id).inspect
          # puts flash.inspect
          # puts response.body

          # RELOAD!! as room1 is just a local variable, get actual information from DB
          expect(room1.reload.group_id).to eq (group1.id)
        end
      end

      it "redirects to manage group path" do
        get :assign_room, {:id => group1.to_param, :room_id => room1.to_param}, valid_session
        expect(response).to redirect_to(manage_rooms_group_path(group1))
      end


    end
  end

end
