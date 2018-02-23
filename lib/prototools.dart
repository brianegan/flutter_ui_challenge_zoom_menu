import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// StateSlider
///
/// A StateSlider is a UI slider that interprets its value as a "state" from a
/// list of "states" as well as a percentage transition from the current "state"
/// to the next "state."
///
/// For example, imagine that there is a list of states such as: closed, opening,
/// open, closing, closed.  If the slider is at position 0.45 then the slider
/// will report a "state" of "open" and a transition percent of 25%. This is
/// because the slider's range of [0.0, 1.0] is being interpreted within a list
/// of 5 states.
class StateSlider<StateType> extends StatefulWidget {

  final List<StateType> states;
  final double value;
  final OnSliderChange<StateType> onSliderChange;

  StateSlider({
    this.states,
    this.value,
    this.onSliderChange,
  });

  @override
  _StateSliderState<StateType> createState() => new _StateSliderState<StateType>(
    sliderValue: value,
  );
}

class _StateSliderState<StateType> extends State<StateSlider<StateType>> {

  double sliderValue;

  _StateSliderState({
    this.sliderValue = 0.0,
  });

  StateType _getStateFromSliderValue(double sliderValue) {
    final stateCount = widget.states.length;
    final stateProgress = stateCount * sliderValue;
    final int stateIndex = stateProgress.floor().clamp(0, stateCount - 1);
    print('New State index: $stateIndex');

    return widget.states[stateIndex];
  }

  double _getStateTransitionPercentFromSliderValue(double sliderValue) {
    final stateCount = widget.states.length;
    final stateListProgress = stateCount * sliderValue;
    final int stateIndex = stateListProgress.floor().clamp(0, stateCount - 1);
    final stateProgress = stateListProgress - stateIndex;
    print('New Progress: $stateProgress');

    return stateProgress;
  }

  @override
  Widget build(BuildContext context) {
    return new Slider(
      value: sliderValue,
      onChanged: (double newValue) {
        setState(() => sliderValue = newValue);

        final newState = _getStateFromSliderValue(newValue);
        final newTransitionPercent = _getStateTransitionPercentFromSliderValue(newValue);
        widget.onSliderChange(new SliderStateChange(newState, newTransitionPercent));
      }
    );
  }
}

class SliderStateChange<StateType> {
  final StateType state;
  final double transitionPercent;

  SliderStateChange(this.state, this.transitionPercent);
}

typedef void OnSliderChange<StateType>(SliderStateChange newSliderState);

/// InnerAnimationCurve
///
/// An InnerAnimationCurve interprets a normal animation value ([0.0, 1.0]) and
/// generates a new animation value within a subset of the original value.
///
/// For example, you may want a particular animation to take place from 0.2 to
/// 0.8 of a larger animation cycle. To accomplish this, you can wrap the original
/// animation value with an InnerAnimationCurve that has an innerStart of 0.2
/// and an innerEnd of 0.8.  Then when the outer animation produces 0.2, the
/// InnerAnimationCurve will produce 0.0.  When the outer animation produces 0.8,
/// the InnerAnimationCurve will produce 1.0.
class InnerAnimationCurve extends Curve {

  final double innerStart;
  final double innerEnd;

  InnerAnimationCurve(this.innerStart, this.innerEnd) {
    assert(innerStart >= 0.0 && innerStart <= 1.0, 'Inner start position must be between 0.0 and 1.0');
    assert(innerEnd >= 0.0 && innerEnd <= 1.0, 'Inner end position must be between 0.0 and 1.0');
    assert(innerStart < innerEnd, 'Inner start must be < inner end');
  }

  @override
  double transform(double t) {
    if (t < innerStart) {
      return 0.0;
    } else if (t > innerEnd) {
      return 1.0;
    } else {
      return (t - innerStart) / (innerEnd - innerStart);
    }
  }
}

/// ForwardAndBackCurve
///
/// Curve that runs an ease-out animation halfway through, and then runs an
/// ease-in-out animation back to the beginning.  Therefore this Curve animates
/// to a destination and back again.
const ForwardAndBackCurve = const _ForwardAndBackCurve();

class _ForwardAndBackCurve extends Curve {

  const _ForwardAndBackCurve();

  @override
  double transform(double t) {
    if (t < 0.5) {
      return Curves.easeOut.transform(t * 2);
    } else {
      return Curves.easeInOut.transform((1.0 - t) * 2);
    }
  }

}

// ReverseCurve
//
// Takes in a value of [0.0, 1.0] and returns [1.0, 0.0] respectively.
const ReverseCurve = const _ReverseCurve();

class _ReverseCurve extends Curve {

  const _ReverseCurve();

  @override
  double transform(double t) {
    return 1.0 - t;
  }
}