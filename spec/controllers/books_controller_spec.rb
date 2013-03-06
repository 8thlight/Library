require 'spec_helper'

describe BooksController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET mybooks" do
    let (:checkout) {mock_model(Checkout)}
    let (:book) {mock_model(Book)}
    let (:user) {mock_model(User)}

    before do
      User.stub(:find_by_id).and_return(user)
      Book.stub(:find_by_id).and_return(book)
      Checkout.stub(:find_by_id).and_return(checkout)
      user.stub(:id).and_return(1)
      checkout.stub(:book_id).and_return(1)
      book.stub(:id).and_return(1)
    end

    it "returns a list of books" do
      get(:mybooks, {'user_id' => 1})
      assert_response :success
    end

    xit "finds all the books the user has checked out" do
      # needs fixing, not sure how to test this in a session
      my_books = Checkout.where(user_id: user.id)
      my_books.should eq(book)
    end
  end

  describe "GET show" do
    let (:book) {mock_model(Book)}
    let (:check_out) {mock_model(Checkout)}

    before do
      Book.stub(:find_by_isbn).and_return(book)
      Checkout.stub(:where).and_return(check_out)
      book.stub(:isbn).and_return("9781934356371")
    end

    it "finds all the checkouts with the id of the book" do
      checked_out_books = Checkout.where(book_id: book.id)
      checked_out_books.should eq(check_out)
    end

    it "retrieves the users name and check out date" do
      checked_out_books = Checkout.where(book_id: book.id)
      checked_out_books.stub(:empty?).and_return(true)
      book.stub(:user).stub(:name).and_return("Taka")
      book.stub(:check_out_date).and_return(Time.now)
      get :show, {:isbn => "9781934356371"}
    end
  end

  describe "POST create" do

    let (:book) { mock_model(Book).as_null_object}

    before do
      Book.stub(:new).and_return(book)
      @attrs = { :title => "Rails Tutorial",
                 :author => "Michael Hartl",
                 :isbn => "1234567890",
                 :quantity =>3}
    end

    it "creates a new book" do
      post :create, {:book => @attrs}
      book.count.should_not == 0
    end

    it "saves a new book" do
      book.should_receive(:save)
      post :create
    end

    context "when the book saves successfully" do
      it "sets a flash[:success] message" do
        post :create
        flash[:success].should eq("The book was saved successfully")
      end

      it "redirects to Book index" do
        post :create
        response.should redirect_to(root_path)
      end
    end

  context "retrieve book information using isbn Google API" do
    book = GoogleBooks.search('9781934356548').first

    it "has the correct title" do
      book.title.should == 'Agile Web Development With Rails'
    end

    it "has the correct author" do
      book.authors.should == "Sam Ruby, Dave Thomas, David Heinemeier Hansson, Leon Breedt"
    end
  end

    context "when the book fails to save" do
      before do
        book.stub(:save).and_return(false)
      end
      it "assigns @book" do
        post :create
        assigns[:book].should eq(book)
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end

      it "sets a flash[:error] message" do
        post :create
        flash[:error].should eq("Please fill in the fields correctly")
      end
    end
  end
end
