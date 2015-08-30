class PeopleController < ApplicationController
  before_action :set_person, only: [ :show, :update, :destroy]

  def index
    @people = Person.all

    render json: @people
  end

  def show
    render json: @person
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def update

    if @person.update(person_params)
      head :no_content
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def destroy

    @person.destroy

    head :no_content
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
      params.require(:person).permit(:full_name, :email, :phone)
  end
end
