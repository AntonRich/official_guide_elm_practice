import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- Main

main =
  Browser.sandbox
    { init = init
    , update = update
    , view = view
    }
    
-- Model

type alias Model =
  { name : String
  , password : String
  , passwordAgain: String
  }
  
init : Model
init =
  Model "" "" ""
  
-- Update

type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
      
    Password password ->
      { model | password = password }
      
    PasswordAgain password ->
      { model | passwordAgain = password }
      
     

-- View

-- TODO: write a submit button that will run a validation first and then send the form to a server.
-- TODO: Validate the length of the passoword not less than 5 characters and it should have numbers.
-- TODO: Validate the name field it should have no integers.

view : Model -> Html Msg
view model =
  Html.form []
    [ div [style "width" "400px"]
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]
    ]
    
viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [type_ t, placeholder p, value v, onInput toMsg ] []
  
viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [style "color" "green", style "text-align" "right" ] [ text "OK" ]
  else
    div [style "color" "red", style "text-align" "right" ] [ text "Passwords do not match!" ]