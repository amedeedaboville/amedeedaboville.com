---
layout: post-light-feature
title: Indistinguishable From Magic Has to Die
description: "It's inaccurate and immoral to think of our hacks as magical."
category: articles
tags: [society, magic, Emerson]
image:
  feature: motherboard_wall.jpg
---

> Any sufficiently advanced technology is indistinguishable from magic. - Arthur C. Clarke

This is everyone in Silicon Valley's favorite quote, and it has to die.
It's wrong, both in the sense that it's factually incorrect, and that it's morally bad for us as a society. 

###Incorrect

Here is the problem: The iPad is not Indistinguishable From Magic (IFM) because of its advanced technology. It's not like in a few years, after
new theories of quantum gravity we'll figure out how it works. The iPad is a jumble of components glued together (ARM CPU, too little RAM, touchscreen) running
a modified linux. It's not magical, it's just packaged that way (fused batteries and all).
We're making a big mistake by marketing these piles of hacks as 'beautiful machines' that 'just work', because they're not.

#It never just works.
Our goal might be that eventually, with enough bug hunting and customer support, it might just work, but it never will.
You can never eliminate bugs from a system. And you can never predict the way a user might use a system. 
http://xkcd.com/1172/
You might have design choices to make that force certain users to get confused.

###Not even good engineering

This goes deeper than marketing, it's also an engineering problem. I admit that at first, the idea that 'it just works' and you don't have to think about anything
else sounds like good engineering, not bad design. All engineering works this way:
You assume the thing does what it's supposed to do, so you can build on top of it. It's hard to see how black boxing could be bad.

Except, as every grizzled engineer knows, abstractions leak. You always spend most of your time in the abstraction layer below yours. A good
engineer knows enough about the layer below to know where the problem is. 
By black boxing the computer, you are giving the user no control at all, because they don't have access to their lower abstraction layer.
They have no way of using their machine in a proper way except by giving it to a Genius.

"But the user doesn't care!" By assumming that, you aren't even _letting_ them care, and then you fuse the battery to the motherboard.
IFM leads to a way of thinking about computers as packaged, commoditized black boxes, that only a select few know how to operate.
That's not a new criticism, that kids using iPads to watch Netflix won't tinker and learn the same way they would with a linux laptop.
But it's part of a bigger issue, the root of which is the idea that technology should be Magic. That it should just work and if it doesn't let
some one at the Store handle it, and you can't possibly deal with it.
Technology is this big complicated thing, you might nick a finger in one of the transistors or flux capacitrons, please don't touch it,
just let the Real Programmers deal with it.

###The wizards

I believe it's primarily us nerds who perpetuate this IFM ideology. We like it and reinforce it because if technology is magic, that makes
us wizards. We enjoy this power. And as much as we enjoy making fun of the way hackers on TV are portrayed as kids
with glasses that hack into the NSA, we get a little bit of social validation from knowing this is how people see us.
We secretly see ourselves that way. If not as little Mitnicks, as 10x multiplier rockstar ninjas that can Do Anything with our
Magic Technology. This then bites us when when senators don't know how computers work and sentence kids who ssh into open machines
to 20 years in prison.

Nerds don't run the world. We build infrastructure that is part of a big social system. 'The internet' doesn't stop at fiber endpoints,
it doesn't start at the application level, it goes way beyond that. We use 'complicated' equations and math and things that many people
don't understand. We take pride in our specialization, but we can't let that inflate our egos.
We're putting 

###How to fix this
We need to put a bigger focus on being able to open up the things we build. Physically, and in software. 
Computers are toys. And there are good toys and there are bad toys. We need to make sure that these things are easy enough to play with.

We are the people with the tools and the power to change things. We've taken a stand against a certain kind of 'RTFM culture', where
it takes half an hour to read a man page.
But now we're assuming "The user doesn't care about parameters, let's just set a good default and not let them change anything".
There is a middle ground. Interfaces are meeting point for humans and computers. They are part human and part computer.
There needs to be a bit of both.
