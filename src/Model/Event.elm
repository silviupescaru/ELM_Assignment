module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"

compareEvents : Event -> Event -> Order
compareEvents eventA eventB =
    Interval.compare eventA.interval eventB.interval

sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith compareEvents events


view : Event -> Html Never
view event =
    let
        eventClasses =
            [ ("event", True)
            , ("event-important", event.important)
            ]

        descriptionClasses =
            [ ("event-description", True) ]
    in
    div [classList eventClasses]
        [ h2 [class "event-title"] [text event.title]
        , p [class "event-category"] [categoryView event.category]
        , p [class "event-interval"] [Interval.view event.interval]
        , p [classList descriptionClasses] [event.description]
        , case event.url of
            Just link ->
                a [class "event-url", href link] [text "Event Link"]

            Nothing ->
                text ""
        ]