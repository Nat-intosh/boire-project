require "application_system_test_case"

class RandomWordsTest < ApplicationSystemTestCase
  setup do
    @random_word = random_words(:one)
  end

  test "visiting the index" do
    visit random_words_url
    assert_selector "h1", text: "Random words"
  end

  test "should create random word" do
    visit random_words_url
    click_on "New random word"

    fill_in "Word", with: @random_word.word
    click_on "Create Random word"

    assert_text "Random word was successfully created"
    click_on "Back"
  end

  test "should update Random word" do
    visit random_word_url(@random_word)
    click_on "Edit this random word", match: :first

    fill_in "Word", with: @random_word.word
    click_on "Update Random word"

    assert_text "Random word was successfully updated"
    click_on "Back"
  end

  test "should destroy Random word" do
    visit random_word_url(@random_word)
    click_on "Destroy this random word", match: :first

    assert_text "Random word was successfully destroyed"
  end
end
