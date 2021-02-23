# The Caypso Manifesto

**Note**: Most of these are my own opinions and are not necessarily reflective of
community of the programming languages in question. (Except, perhaps JS. JS is
just unequivocally and demonstrably awful.)

> Calypso is a mostly imperative language with some functional influences that
> is focues on flexibility and simplicity.

This is the tagline for Calypso on [its GitHub page][cal-gh]. However, what does
this mean, exactly? In this post, I'm going to explain my ideology for Calypso:
why I started writing it, and what I'd like it to become.

## The Creation of Calypso

As you may or may not know, I love [Rust] and [Elixir]. However, there are just
some things that Elixir isn't suited for. And there are some things that Rust
isn't the best for. Sometimes, Rust seems like overkill or seems like too slow
of a development time due to its long compilation times or complex type system.
This draws me towards more dynamic languages like Elixir. However, Elixir, being
inherently tied to the BEAM and Erlang/OTP, has features like immutable
variables (though you can rebind them), and OTP is the main "application
framework" for Elixir/Erlang. OTP is a really good design philosophy for
applications, but I find that it's sometimes kind of hard to set up for some
applications, with its actor concurrency model and supervision. It's a large
amount of things to think of while designing even simple applications.

I have also found that already available scripting-like languages such as JS and
Python are not really that easy to work with when scaling up; for example, JS,
with its **MANY** design issues (e.g. implicit coercion), and Python, which
while working pretty well when scaled up, is kind of hard to maintain in my
opinion.

And that's why I created Calypso. I enjoy Rust and Elixir but for some
applications, including scripts that are not quite full applications but not
quite worthy of being a Bash script. Also, sometimes I have applications that
are not really the best suited for either and are better suited for a more
dynamic environment. 

## Calypso's Guiding Principles

Calypso strives to cover these principles:
- Flexibility, i.e. you don't have to "hack" the language to do more complex
    things.
- Simplicity, i.e. code is expressive but not too verbose.
- A reciprocal combination of these two: flexibility **and** simplicity, i.e.
    allowing simplicity without sacrificing flexibility and allowing flexibility
    without sacrificing simplicity.
- Performance, i.e. code shouldn't have to be micro-optimized, code should run
    well enough without sacrificing flexibility or simplicity. As I'm not that
    experienced with optimization, this may take a while to implement.

These principles also apply to the standard library/ies of Calypso, which should
be expressive but flexible and performant.

Calypso is mainly influenced by Rust, Elixir, and Erlang. In terms of overall
architecture, it's mainly inspired by Rust. However, there are some functional
influences from both Erlang and Elixir, intended to help ensure flexibility and
simplicity. Erlang is described as a functional language that breaks free to the
imperative world at some points, whereas I would describe Calypso as the
opposite: an imperative language that breaks free to the functional world at
some points. While these seem like similar concepts, they're somewhat different
in nature. Calypso aims to be familiar but introduce some unfamiliar concepts
from the functional world that can help to keep code short, simple, flexible,
and maintainable.

## What I'd Like Calypso to Become

Personally, I'd like to see Calypso become a language that is used for
applications, simple and complex, offline and online, command-line and
graphical.

As I'm not really a fan of Python, and I'm an enthusiast of binary exploitation
and CTFs, I may eventually port at least some of [pwntools] to Calypso. I might
end up implementing some of it in Rust, as I do plan to have FFI as a major part
of Calypso, or at least the VM behind it, Odysseus.

## What Calypso is Not Going to Become

I'm not expecting Calypso to replace Rust or Elixir or JS or Python or, well,
really anything. It's not created with that in mind--it *definitely* isn't a
systems language and probably won't have as good concurrency as Elixir (though I
hope I can make concurrency work pretty well).

I'm hoping Calypso can be used to make applications that could otherwise be made
in Rust or Elixir but I'm not expecting it to singlehandedly replace the
entirety of those languages. That's just not a goal for it.

Calypso will probably not be as fast as Rust or Elixir either. It's intended to
be simple, so it will definitely compile faster than Rust but I'm not expecting
it to particularly rival performance of either language. It may be about as fast
as Elixir as some point, but as a non-systems language it's definitely not going
to rival Rust's performance without JIT (which I currently don't have plans
for).

## Updates

2021/02/22: Added "What Calypso is Not Going To Become" section

[cal-gh]: https://github.com/calypso-lang/calypso
[Rust]: https://rust-lang.org
[Elixir]: https://elixir-lang.org
[pwntools]: https://github.com/Gallopsled/pwntools#readme
