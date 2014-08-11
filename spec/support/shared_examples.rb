shared_examples "require log in" do
  it "redirects to register path" do
    action
    expect(response).to redirect_to register_path
  end
end

shared_examples 'require admin' do
  before do
    set_current_user
    action
  end
  it 'redirects to home path' do
    expect(response).to redirect_to home_path
  end
  it 'shows error flash' do
    expect(flash[:danger]).to be_present
  end
end
