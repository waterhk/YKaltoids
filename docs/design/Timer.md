# Timer #

`Timer` is intended for basic profiling. Its initial implementation is simplistic; if our needs grow, we can add features.

## Usage ##

Each timing operation is associated with a tag (an arbitrary string label), allowing a single timer to be used to time multiple events.

Each `beginAccumulatingForTag:` must be matched by a call to `stopAccumulatingForTag:` with the same tag.

Multiple time periods can be accrued for a single tag (e.g., to sum the time taken by one of multiple operations in a loop) by simply reusing the same tag in multiple `beginAccumulatingForTag:` and `stopAccumulatingForTag:` calls. Note however that `stopAccumluatingForTag:` must be called before re-invoking `beginAccumulatingForTag:` for a given tag (timings cannot overlap for a single tag).

## Injection ##

Most clients will need the ability to create a timer, so their .aff config should register a dependency on `timerInstanceFactory`, and on that instance factory they should call `createTimer` to get an actual `id<Timer>`.

It is also possible to be directly injected with a timer by registering a dependency on `timer` itself. Your component will get its own instance of a timer in this case, not shared with any other component. Note however that if your timing code executes more than once, it will accumulate on top of previous executions. There is currently no support for resetting a timer.

## Example ##

	[timer beginAccumulatingForTag:@"total"];
	
	while(!done)
	{
		[timer beginAccumulatingForTag:@"processing zergs"];
		[self processZerg];
		[timer stopAccumulatingForTag:@"processing zergs"];
		
		[timer beginAccumulatingForTag:@"processing protosses"];
		[self processProtosss];
		[timer stopAccumulatingForTag:@"processing protosses"];
	}
	
	[timer stopAccumulatingForTag:@"total"];
	
	NSTimeInterval secondsToProcessZergs = [timer accumulatedSecondsForTag:@"processing zergs"];
	
	// log a human-readable dump of total, processing zergs, and processing protosses timings
	NSLog(@"total timings: %@", [timer descriptionOfAccumulatedSecondsForAllTags]);