require "test_helper"

class RandomWordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @random_word = random_words(:one)
  end

  test "should get index" do
    get random_words_url
    assert_response :success
  end

  test "should get new" do
    get new_random_word_url
    assert_response :success
  end

  test "should create random_word" do
    assert_difference("RandomWord.count") do
      post random_words_url, params: { random_word: { word: @random_word.word } }
    end

    assert_redirected_to random_word_url(RandomWord.last)
  end

  test "should show random_word" do
    get random_word_url(@random_word)
    assert_response :success
  end

  test "should get edit" do
    get edit_random_word_url(@random_word)
    assert_response :success
  end

  test "should update random_word" do
    patch random_word_url(@random_word), params: { random_word: { word: @random_word.word } }
    assert_redirected_to random_word_url(@random_word)
  end

  test "should destroy random_word" do
    assert_difference("RandomWord.count", -1) do
      delete random_word_url(@random_word)
    end

    assert_redirected_to random_words_url
  end
end
