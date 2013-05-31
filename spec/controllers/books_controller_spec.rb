require 'spec_helper'

describe BooksController do

  describe "#book_preview" do
    it "retrieves book from book/new" do
      book = mock_model(Book, :title => "foo")
      Book.should_receive(:new).and_return(book)
      get 'preview'
      book.title.should == "foo"
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      Book.should_receive(:new)
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should return book" do
      book = mock_model(Book, :isbn => "9781934356371", :quantity_left => 1)
      Book.should_receive(:find_by_isbn).with("9781934356371").and_return(book)
      get 'edit', {:isbn => "9781934356371"}
      book.isbn.should == "9781934356371"
      book.quantity_left.should == 1
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @book = Book.new(isbn: "9781934356371", quantity: 1, quantity_left: 1)
      Book.stub(:find_by_isbn).with("9781934356371").and_return(@book)
    end

    it "updates attribute of the book" do
      @book.should_receive(:update_attributes).and_return(true)
      put 'update', {:isbn => "9781934356371", :book => {:quantity => 2}}
      @book.quantity_left.should == 2
    end

    it "should redirect to show page" do
      response.code.should eq("200")
      put 'update', {:isbn => "9781934356371", :book => {:quantity => 2}}
    end
  end

  describe "GET mybooks" do
    let (:checkout) {mock_model(Checkout)}

    it "returns a list of books" do
      get(:mybooks, {'user_id' => 1})
      assert_response :success
    end

    it "finds all the books the user has checked out" do
      Checkout.should_receive(:where).and_return(checkout)
      subject.mybooks
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
