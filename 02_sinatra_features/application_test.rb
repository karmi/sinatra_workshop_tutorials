require 'rubygems'
require 'sinatra'
require 'sinatra/test/unit'
require 'application'

class ApplicationTest < Test::Unit::TestCase
  
  configure do
    # ...
  end

  def test_index_returns_properly
    get '/'
    assert_equal @response.status,  200
    assert @response.body =~ /You have 3 templates/
  end

  def test_detail_returns_properly
    get '/views/item.erb'
    assert_equal @response.status, 200
    assert @response.body =~ /Contents of template item.erb/
  end

  def test_not_found_returns_404
    get 'this/is/not/there'
    assert_equal @response.status, 404
  end

  def test_missing_file_returns_500
    assert_raise(Errno::ENOENT) do
      get '/views/missing.file'
      assert_equal @response.status, 500
    end
  end

end
