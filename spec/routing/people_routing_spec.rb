require 'rails_helper'

RSpec.describe PeopleController, type: :routing do

  it { expect(get:    "/people").to   route_to("people#index") }
  it { expect(get:    "/people/1").to route_to("people#show", id: "1") }
  it { expect(post:   "/people").to   route_to("people#create") }
  it { expect(put:    "/people/1").to route_to("people#update", id: "1") }
  it { expect(delete: "/people/1").to route_to("people#destroy", id: "1") }

end
