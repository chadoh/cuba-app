require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"
require_relative "./models/student"

Cuba.use Rack::Session::Cookie, :secret => ENV["SESSION_SECRET"] || "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

Cuba.define do
  on root do
    res.write view("index", students: Student.all)
  end

  on get, "new" do
    res.write view("new")
  end

  on post, "create" do
    Student.create(
      name: req.params["name"],
      email: req.params["email"],
      discord: req.params["discord"],
    )
    res.redirect "/"
  end

  on get, "edit/:id" do |id|
    res.write view("edit", student: Student.find(id))
  end

  on post, "update/:id" do |id|
    student = Student.find(id)
    student.update(
      name: req.params["name"],
      email: req.params["email"],
      discord: req.params["discord"],
    )
    res.redirect "/"
  end

  on post, "delete/:id" do |id|
    student = Student.find(id)
    student.destroy
    res.redirect "/"
  end

  def not_found
    res.status = "404"
    res.headers["Content-Type"] = "text/html"

    res.write view("404")
  end
end
