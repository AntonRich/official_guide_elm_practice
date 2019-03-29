module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, div, input, text, label)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onInput)
import Maybe



-- Main


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Model =
    { content : String
    , repeat : Int
    }


init : Model
init =
    { content = ""
    , repeat = 1
    }



-- Update


type Msg
    = Change String
    | Repeat String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }
        Repeat number ->
            { model | repeat = (Maybe.withDefault 0 (String.toInt number)) }


-- I have tried to refactor that code. Got an interestig Error Message.

view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change] []
        , div [] ( List.repeat (model.repeat) (div [] [text (String.reverse model.content)]) )
        , input [ style "transform" "rotate" "90", style "transform-origin" "75" "75", type_ "range", Attr.min "1", Attr.max "10", onInput Repeat, name "multipleOutputs" ] []
        , label [ for "multipleOutputs" ] [ text "Increase the output" ]
        ]




-- view : Model -> Html Msg
-- view model =
--     div []
--         [ input [ placeholder "Text to reverse", value model.content, onInput Change] []
--         , div [] ( List.repeat (model.repeat) (div [] [text (String.reverse model.content)]) )
--         , input [ type_ "range", Attr.min "1", Attr.max "10", value (String.fromInt model.repeat), name "multipleOutputs" ] []
--                                                               Here is the question. How do I make an update here?
--         , label [ for "multipleOutputs" ] [ text "Increase the output" ]
--         ]

-- repeater model =
--     List.repeat model.repeat ( div [] [text (String.reverse model.content)] )

-- Original code. Was refactored into the code above.
-- view model =
--     div []
--         (
--         [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []]
--         ++
--         (List.repeat (model.repeat) (div [] [text (String.reverse model.content)]))
--         ++
--         [ input [type_ "range", Attr.min "1", Attr.max "10", value (String.fromInt model.repeat), name "multipleOutputs"] []
--         , label [for "multipleOutputs"] [text "Increase the output."]
--         ]
--         )

-- TODO: Make a repeat function that will take div with String.revers and will repeat that function
--       n numbers of times.

-- Ways to solve. Reduce, map, simulate the repeat function in Haskell, or cycles.

-- I have a feeling there should be another helper function for func


-- helper model =
--     div [] [text (String.reverse model.content)]


-- Trying to solve it with recursion. 
-- repeat : Int -> (a -> b) -> Html msg
-- repeat n func =
-- repeat n func =
--     case n == 0 of
--         True -> 0 -- It cannot be zero. because then the function will return an integere. Which is a wrong type. It should be Html msg.
--         False -> 