LoadCompumedicsAnnotationsClass
===============================

Load sleep stage and event information from a Compumedics file


Function Prototypes:

    obj = loadComumedicsAnnotations (fn)

Public Properties

      subjectId: Used to label plots
    figPosition: Move to generated figure position, if set
       scoreKey: Key for translating output numeric code to stage IDs 


Dependent Properties

    uniqueStageText: Unique stage
      numericHypnogram: Numeric hypnogram [1:num epochs]'
     characterHypnogram: Character hypnogram [1:num epochs]'
         normalizeHyp: hypnogram [t(0 100) stage]
           numHypDist:  Distributed numeric hypnogram [t(0-100) stage]
           xmlEntries: XMl entry types
          ScoredEvent: Scored event structure
            EventList: List of events
           EventTypes: Unique event entry types
           EventStart: Event start list
          SleepStages: List of sleep stages
          EpochLength: Epoch length 
 
Public Methods

    obj = plotHypnogram
    obj = plotHypnogramWithDist
