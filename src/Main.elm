module Main exposing (main)

import Browser
import Html as Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task exposing (..)
import Time as Time exposing (..)


type alias Model =
    { date : Maybe Posix }


type alias Flags =
    String


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { date = Nothing }, Cmd.none )


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type Msg
    = RequestDate
    | ReceiveDate Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestDate ->
            ( model, Task.perform ReceiveDate Time.now )

        ReceiveDate date ->
            ( { model | date = Just date }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick RequestDate ] [ text "Get time" ]
        , text
            (model.date
                |> Maybe.map toUtcString
                |> Maybe.withDefault "Don't know yet"
            )
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


toUtcString : Time.Posix -> String
toUtcString time =
    String.fromInt (toHour utc time)
        ++ ":"
        ++ String.fromInt (toMinute utc time)
        ++ ":"
        ++ String.fromInt (toSecond utc time)
        ++ " (UTC)"
