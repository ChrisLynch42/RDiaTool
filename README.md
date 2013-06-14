RDiaTool
========

RDiaTool is a utility written in Ruby that parses uncompressed Dia  files to produce helpful results.  The first helpful result will be parsing database diagrams and then generating helpful code from said diagrams.  The goal is not only to generate code from a diagram but to also to update existing code from the diagram.  This way the tool becomes part of the ongoing development process rather than one time during beginning of the process.  Currently it is only useful starting up a project.  The hope is that the next few months will see that change.

## Code Generation Languages

The current plan is to output code for Ruby On Rails, Backbone.js and Meteorjs.  Adding the Meteorjs capability is in progress while the
others have not been started.
