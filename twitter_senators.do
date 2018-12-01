clear

//log using c:\senate_round1.log//

use "/Users/anisaholmes/Documents/BROWN/2014-2015/ECON1400/final paper/senate.dta"

set more off


//summary of data//

gen Infla_fin=Campaign_fin if Year==2010

replace Infla_fin=(Campaign_fin*1.0128) if Year==2008


sum Twitter DEM_party REP_party if Year==2008

sum Twitter DEM_party REP_party if Year==2010

tab Twitter DEM_party if Year==2008
tab Twitter DEM_party if Year==2010

tab Twitter REP_party if Year==2008
tab Twitter REP_party if Year==2010


reg Vote_share Incumbent, robust


//regression for 2008//

drop if Year==2010

reg Vote_share Twitter Incumbent L_Fin_state, robust

reg Vote_share Twitter Incumbent REP_state DEM_state, robust

reg Vote_share Twitter Incumbent REP_state_party DEM_state_party, robust


//regression for 2010//

clear

use "/Users/anisaholmes/Documents/BROWN/2014-2015/ECON1400/final paper/senate.dta"

drop if Year==2008

reg Vote_share Twitter Incumbent L_Fin_state, robust

reg Vote_share Twitter Incumbent REP_state DEM_state, robust

reg Vote_share Twitter Incumbent REP_state_party DEM_state_party, robust


//fixed effects with both years//




clear

use "/Users/anisaholmes/Documents/BROWN/2014-2015/ECON1400/final paper/senate.dta"

gen L_Fin_state=(log(Infla_fin))



areg Vote_share Twitter Incumbent L_Fin_state i.Year, absorb(State_nu)

areg Vote_share Twitter Incumbent REP_party DEM_party i.Year, absorb(State_nu)

areg Vote_share Twitter Incumbent REP_state_party DEM_state_party i.Year, absorb(State_nu)

areg Vote_share Twitter Incumbent REP_party DEM_party REP_state_party DEM_state_party i.Year, absorb(State_nu)

areg Vote_share Twitter Incumbent L_Fin_state REP_party DEM_party REP_state_party DEM_state_party i.Year, absorb(State_nu)



//log close//
