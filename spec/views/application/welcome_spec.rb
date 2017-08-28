require "spec_helper"

describe "application/welcome" do
  it "displays welcome message" do
    render

    expect(rendered).to match(/This is application for creating task list/)
    expect(rendered).to match(/Write down all your important things there, so as not to forget/)
    expect(rendered).to match(/Start/)
  end
end