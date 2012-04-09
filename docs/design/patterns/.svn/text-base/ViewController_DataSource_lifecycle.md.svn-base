# ViewController / DataSource lifecycle #

**TODO**

    * identify different VC/DataSource lifecycle types in Hub (e.g., long-lived/one-instance like Conversations List vs. short-lived/multi-instance like Conversation Details)
	* for each ViewController lifecycle type,
		* test and define proper DataSource lifecycle
			* when to assign/clear VC's table view's dataSource
			* when to assign/clear VC (or other object) as delegate to data source
			* when to load/unload data source
		* test and define proper lifecycle for other resources
			* notification/observation
			* contact repository subscription
	* develop reusable unit test library so all VCs can easily/automatically be validated for viewDidAppear, viewWillAppear, viewDidLoad, etc. all conforming to proper lifecycle