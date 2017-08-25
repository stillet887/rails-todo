require "spec_helper"

describe "application/welcome" do
  it "displays welcome message" do
    render

    rendered.should =~ /This is application for creating task list/
    rendered.should =~ /Write down all your important things there, so as not to forget/
    rendered.should =~ /Start/
  end
end