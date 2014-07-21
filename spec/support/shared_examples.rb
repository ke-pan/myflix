shared_examples "require log in" do
  it "redirects to register path" do
    action
    expect(response).to redirect_to register_path
  end
end