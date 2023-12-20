module Pages.Day04 exposing (..)

import Html exposing (Html, button, div, h1, p, text, textarea)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import List.Extra
import Set exposing (Set)


init : Model
init =
    { content = ""
    , result = ""
    , result2 = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ textarea [ placeholder "Please paste card sets here.", value model.content, onInput Change ] []
        , h1 [] [ text "Part 1" ]
        , p []
            [ button [ onClick GetWinningPoints ] [ text "Compute" ]
            , text (String.append "Result: " model.result)
            ]
        , h1 [] [ text "Part 2" ]
        , p []
            [ text "tba"
            ]
        ]


type alias Model =
    { content : String
    , result : String
    , result2 : String
    }


type Msg
    = Change String
    | GetWinningPoints


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent, result = "", result2 = "" }

        GetWinningPoints ->
            { model | result = String.fromInt (resultPart1 model.content) }


listsOfNumbers : String -> List (List (List Int))
listsOfNumbers scratchcards =
    scratchcards
        |> String.lines
        |> List.map
            (\s ->
                String.split ":" s
                    |> List.Extra.last
                    |> Maybe.withDefault ""
                    |> String.split "|"
                    |> List.map
                        (\n ->
                            String.words n
                                |> List.map
                                    (\w ->
                                        String.toInt w
                                            |> Maybe.withDefault 0
                                    )
                        )
            )


winningNumbers : List (List Int) -> Int
winningNumbers listOfNums =
    listOfNums
        |> List.map Set.fromList
        |> section


section : List (Set Int) -> Int
section card =
    card
        |> (\s -> Set.intersect (Maybe.withDefault Set.empty (List.head s)) (Maybe.withDefault Set.empty (List.Extra.last s)))
        |> Set.size


points : List Int -> Int
points winNum =
    winNum
        |> List.map (\n -> sectionToPoints n)
        |> List.sum


sectionToPoints : Int -> Int
sectionToPoints n =
    if n <= 0 then
        0

    else
        2 ^ (n - 1)


resultPart1 : String -> Int
resultPart1 scratchcards =
    scratchcards
        |> listsOfNumbers
        |> List.map winningNumbers
        |> points
