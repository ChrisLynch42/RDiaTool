RDiaTool
========

RDiaTool is a utility written in Ruby that parses uncompressed Dia  files to produce helpful results.  It is currently under development and is not ready for use.  

The first step is to parse Dia database diagrams and then generate helpful code from said diagrams.  The goal is not only to generate code but to update previously generated code without corrupting additions and modifications made by a developer.  This way the tool becomes part of the ongoing development process rather than one time use during beginning of the process.  Currently it is only useful starting up a project.  The hope is that the next few months will see that change.

## Code Generation Languages

The current plan is to output code for Ruby On Rails, Backbone.js and Meteorjs.  Adding the Meteorjs capability is in progress while the
others have not been started.
