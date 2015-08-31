require 'rails_helper'

RSpec.describe PeopleController, type: :controller do

  before do
    let!(:user) { create(:user) }
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end

  it_behaves_like "api_controller"
  it_behaves_like "authenticated_api_controller"

  let!(:person) { create(:person)}


  describe "GET #index" do
    it "assigns all people as @people" do
      get :index, { format: :json }
      expect(assigns(:people)).to include(person)
    end
  end

  describe "GET #show" do
    it "assigns the requested person as @person" do
      get :show, { id: person.id, format: :json }
      expect(assigns(:person)).to eq person
    end
  end

  describe "POST #create" do

    context "with valid params" do
      let(:person_attrs) { attributes_for(:person)}

      it "creates a new Person" do
        expect {
          post :create, { person: person_attrs, format: :json  }
        }.to change{Person.count}.by(1)
      end

      it "assigns a newly created person as @person" do
        post :create, { person: person_attrs, format: :json  }
        expect(assigns(:person)).to be_a(Person)
        expect(assigns(:person)).to be_persisted
      end
    end

    context "with invalid params" do


      it "assigns a newly created but unsaved person as @person" do

        post :create, { person: { phone: "1234567890" }, format: :json  }
        expect(assigns(:person)).to be_a_new(Person)
      end

      it "returns unprocessable_entity status" do
        post :create, { person: { phone: "1234567890" }, format: :json  }
        expect(response.status).to eq 422
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      it "updates the requested person" do
        put :update, { id: person.id, person: { full_name: "John F. Doe"}, format: :json  }
        person.reload
        expect(person.full_name).to eq "John F. Doe"
      end

      it "assigns the requested person as @person" do
        put :update, { id: person.id, person: { full_name: "John F. Doe"}, format: :json  }
        expect(assigns(:person)).to eq person
      end
    end

    context "with invalid person params" do
      it "assigns the person omer as @person " do
        put :update, { id: person .id, person: { full_name: nil} , format: :json  }
        expect(assigns(:person)).to eq person
      end

      it "returns unprocessable_entity status" do
        put :update, { id: person.id, person: { full_name: nil } , format: :json }
        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested person" do
      expect {
        delete :destroy, { id: person.id, format: :json  }
      }.to change{Person.count}.by(-1)
    end

    it "redirects to the peoples list" do
      delete :destroy, { id: person.id, format: :json  }
      expect(response.status).to eq 204
    end
  end
end
