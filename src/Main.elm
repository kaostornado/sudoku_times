module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { dieFace : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "has-text-centered" ]
        [ h1 [] [ text (String.fromInt model.dieFace) ]
        , button
            [ class "button"
            , class "has-background-danger-light"
            , onClick Roll
            ]
            [ text "Roll" ]
        , div [ class "has-text-centered" ]
            [ makeTable 9 (List.concat <| List.repeat 9 <| List.range 1 9) ]
        , div []
            [ div [ class "has-text-centered" ]
                [ makeTable 16 (List.concat <| List.repeat 16 <| List.range 1 16)
                ]
            ]
        , div []
            [ div [ class "has-text-centered" ]
                [ makeTable 16 (List.concat <| List.repeat 16 <| List.range 1 16)
                ]
            ]
        ]



-- VIEW Functions


makeVerticalLine sqrtSize x =
    if modBy sqrtSize x == 0 then
        class "is-solid-right"

    else if modBy sqrtSize x == 1 then
        class "is-solid-left"

    else
        class ""


makeHorizontalLine sqrtSize index =
    let
        rowNumber =
            index + 1
    in
    if modBy sqrtSize rowNumber == 0 then
        class "is-solid-bottom"

    else if modBy sqrtSize rowNumber == 1 then
        class "is-solid-top"

    else
        class ""


makeTableRow size index numbers =
    let
        sqrtSize =
            round <| sqrt <| toFloat size
    in
    tr [ makeHorizontalLine sqrtSize index ] <|
        List.map (\x -> td [ makeVerticalLine sqrtSize x ] [ text <| String.fromInt x ]) numbers


splitList : Int -> List a -> List (List a)
splitList split list =
    if list == [] then
        []

    else if split == 1 then
        [ list ]

    else
        List.take split list :: splitList split (List.drop split list)


makeTable size listOfNumbers =
    let
        seperatedListOfNumbers =
            splitList size listOfNumbers
    in
    table [ class "table", class "is-bordered", class "is-centered" ] <|
        List.indexedMap (\index x -> makeTableRow size index x) seperatedListOfNumbers
