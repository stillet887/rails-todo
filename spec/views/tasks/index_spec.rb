require "spec_helper"

describe "tasks/index" do
  it "displays all the tasks" do
    title_1, title_2 = Faker::ElderScrolls.dragon, Faker::ElderScrolls.dragon

    assign(:tasks, [
        stub_model(Task, title: title_1),
        stub_model(Task, title: title_2)
    ])

    render

    expect(rendered).to match(/Tasks/)
    expect(rendered).to match(title_1)
    expect(rendered).to match(title_2)
    expect(rendered).to match(/Create new task/)
  end
end