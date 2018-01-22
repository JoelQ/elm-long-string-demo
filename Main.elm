module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http

type Msg = FetchString | GotString (Result Http.Error String)

initialModel : String
initialModel =
    "short string"

view : String -> Html Msg
view string =
  div []
    [ button [onClick FetchString] [ text "Get Long Text" ]
    , p [] [ text "Try to click in here to see if the browser locked up" ]
    , div [] [ textarea [] [] ]
    , pre [] [ text string ]
    ]

update : Msg -> String -> (String, Cmd Msg)
update msg model =
  case msg of
    FetchString ->  (model, Http.getString "tale_of_two_cities.txt" |> Http.send GotString)
    GotString (Ok string) -> (string, Cmd.none)
    GotString (Err string) -> (model, Cmd.none)

main : Program Never String Msg
main =
  Html.program
    { init = (initialModel, Cmd.none)
    , update = update
    , view = view
    , subscriptions = always Sub.none
    }
