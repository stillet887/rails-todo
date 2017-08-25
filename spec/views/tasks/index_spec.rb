require "spec_helper"

describe "tasks/index" do
  it "displays all the tasks" do
    assign(:tasks, [
        stub_model(Task, :title => "task description 1"),
        stub_model(Task, :title => "task description 2")
    ])

    render

    rendered.should =~ /Tasks/
    rendered.should =~ /task description 1/
    rendered.should =~ /task description 2/
    rendered.should =~ /Create new task/
  end
end