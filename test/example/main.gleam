// IMPORTS ---------------------------------------------------------------------

import lustre.{ Element }
import lustre/element

import example/application/counter

// MAIN ------------------------------------------------------------------------

pub fn main () -> Nil {
    let selector = "[data-lustre-container]"
    let program  = lustre.application(init(), update, render)

    // `lustre.start` can return an `Error` if no DOM element is found that matches
    // the selector. This is a fatal error for our examples, so we panic if that 
    // happens.
    assert Ok(_) = lustre.start(program, selector)

    Nil
}

// STATE -----------------------------------------------------------------------

type State {
    State(
        counter: counter.State
    )
}

fn init () -> State {
    State(
        counter: counter.init()
    )
}

// UPDATE ----------------------------------------------------------------------

type Action {
    Counter(counter.Action)
}

fn update (state: State, action: Action) -> State {
    case action {
        Counter(counter_action) ->
            State(counter: counter.update(state.counter, counter_action))
    }
}

// RENDER ----------------------------------------------------------------------

fn render (state: State) -> Element(Action) {
    element.div([], [
        element.details([], [
            element.summary([], [ element.text("Counter") ]),
            counter.render(state.counter) 
                |> element.map(Counter)
        ])
    ])
}
