/*
  I create four encapsulated 'display' function for each section ( bio, work, project and education)
  I also create Info Window for each map marker.

  I think i found two errors (latitude and longitude) in map marker section of helper.js.
    var lat = placeData.geometry.location.k; (.lat() instead of .k)
    var lon = placeData.geometry.location.D; (.lng() instead of .D)
*/
$(window).load(function() {

    /*
    This function is created to be called from the encapsulated 'display' function of each section ( bio, work, project and education)
    parameters
	1- helperTag 	- variable name from helper.js
	2- datea 	- data from json file
	3- tagId	- htm tag to append or prepend 
	4- pre		- 0 (Append)
			  1 (Prepend)
  */

    function replaceAppend(helperTag, data, tagId, pre) {
        var formatted;
        if (data.trim().length !== 0) {
            formatted = eval(helperTag).replace('%data%', data);
        } else {
            formatted = eval(helperTag);
        }
        if (pre) {
            $(tagId).prepend(formatted);
        } else {
            $(tagId).append(formatted);
        }
    }

    //*********************** Bio **************************************

    bio.display = function() {
        var bioArray = [
            ['HTMLheaderRole', bio.role, '#header', 1],
            ['HTMLheaderName', bio.name, '#header', 1],
            ['HTMLmobile', bio.contacts.mobile, '#topContacts', 0],
            ['HTMLemail', bio.contacts.email, '#topContacts', 0],
            ['HTMLgithub', bio.contacts.github, '#topContacts', 0],
            ['HTMLtwitter', bio.contacts.twitter, '#topContacts', 0],
            ['HTMLlocation', bio.contacts.location, '#topContacts', 0],
            ['HTMLbioPic', bio.biopic, '#header', 0],
            ['HTMLWelcomeMsg', bio.welcomeMessage, '#header', 0]
        ];

        if (bio.skills.length > 0) {
            bioArray.push(['HTMLskillsStart', "", '#header', 0]);
            bioArray.push(['HTMLskills', bio.skills[0], '#header', 0]);
            bioArray.push(['HTMLskills', bio.skills[1], '#header', 0]);
            bioArray.push(['HTMLskills', bio.skills[2], '#header', 0]);
        }

        for (var arrIndex=0;  arrIndex < bioArray.length; arrIndex++) {
            replaceAppend(bioArray[arrIndex][0], bioArray[arrIndex][1], bioArray[arrIndex][2], bioArray[arrIndex][3]);
        }
        
        // *********************************  Footer Contacts *******************************

        var footerContactArray = [
            ['HTMLmobile', bio.contacts.mobile, '#footerContacts', 0],
            ['HTMLemail', bio.contacts.email, '#footerContacts', 0],
            ['HTMLgithub', bio.contacts.github, '#footerContacts', 0],
            ['HTMLtwitter', bio.contacts.twitter, '#footerContacts', 0],
            ['HTMLlocation', bio.contacts.location, '#footerContacts', 0]
        ];
        
        for (var arrIndex=0;  arrIndex<footerContactArray.length; arrIndex++) {
            replaceAppend(footerContactArray[arrIndex][0], footerContactArray[arrIndex][1], footerContactArray[arrIndex][2], footerContactArray[arrIndex][3]);
        }

    };

    bio.display();

    //***************************** Work*************************************

    work.display = function() {
        var workArray;
        for (var jobIndex=0; jobIndex<work.jobs.length; jobIndex++) {
            workArray = [
                ['HTMLworkEmployerTitle', (work.jobs[jobIndex].employer + " - " + work.jobs[jobIndex].title), '.work-entry', 0],
                ['HTMLworkDates', work.jobs[jobIndex].dates, '.work-entry', 0],
                ['HTMLworkLocation', work.jobs[jobIndex].location, '.work-entry', 0],
                ['HTMLworkDescription', work.jobs[jobIndex].description, '.work-entry', 0]
            ];

            if (jobIndex === 0) {
                workArray.unshift(['HTMLworkStart', '', '#workExperience', 0]);
            }
            for (var arrIndex=0; arrIndex<workArray.length; arrIndex++) {
                replaceAppend(workArray[arrIndex][0], workArray[arrIndex][1], workArray[arrIndex][2], workArray[arrIndex][3]);
            }
        }
    };
    work.display();

    //*************************  Projects ************************************

    projects.display = function() {
        var projectArray;
        for (var projectIndex=0; projectIndex<projects.projects.length; projectIndex++) {
            projectArray = [
                ['HTMLprojectTitle', projects.projects[projectIndex].title, '.project-entry', 0],
                ['HTMLprojectDates', projects.projects[projectIndex].dates, '.project-entry', 0],
                ['HTMLprojectDescription', projects.projects[projectIndex].description, '.project-entry', 0]
            ];
            for (var imgIndex=0; imgIndex<projects.projects[projectIndex].images.length; imgIndex++) {
                projectArray.push(['HTMLprojectImage', projects.projects[projectIndex].images[imgIndex], '.project-entry', 0]);
            }

            if (projectIndex === 0) {
                projectArray.unshift(['HTMLprojectStart', '', '#projects', 0]);
            }

            for (var arrIndex=0; arrIndex<projectArray.length; arrIndex++) {
                replaceAppend(projectArray[arrIndex][0], projectArray[arrIndex][1], projectArray[arrIndex][2], projectArray[arrIndex][3]);
            }
        }
    };
    projects.display();

    //***************************  Education  School ***************************

    education.display = function() {
        var schoolArray;
        for (var schoolIndex=0; schoolIndex<education.schools.length; schoolIndex++) {
            schoolArray = [
                ['HTMLschoolNameDegree', (education.schools[schoolIndex].name + ' -- ' + education.schools[schoolIndex].degree), '.education-entry', 0],
                ['HTMLschoolDates', education.schools[schoolIndex].dates, '.education-entry', 0],
                ['HTMLschoolLocation', education.schools[schoolIndex].location, '.education-entry', 0]
            ];
            for (var majorIndex=0; majorIndex<education.schools[schoolIndex].majors.length; majorIndex++) {
                schoolArray.push(['HTMLschoolMajor', education.schools[schoolIndex].majors[majorIndex], '.education-entry', 0]);
            }
            if (schoolIndex === 0) {
                schoolArray.unshift(['HTMLschoolStart', '', '#education', 0]);
            }
            for (var arrIndex=0; arrIndex<schoolArray.length; arrIndex++) {
                replaceAppend(schoolArray[arrIndex][0], schoolArray[arrIndex][1], schoolArray[arrIndex][2], schoolArray[arrIndex][3]);
            }
        }
 
        //***************************  Education  OnlineCourse ************************

        var onlineCourseArray;
        for (var onlineCourseIndex=0; onlineCourseIndex<education.onlineCourses.length; onlineCourseIndex++) {
            onlineCourseArray = [
                ['HTMLonlineTitleSchool ', (education.onlineCourses[onlineCourseIndex].title + ' - ' + education.onlineCourses[onlineCourseIndex].school), '.education-entry', 0],
                ['HTMLonlineDates', education.onlineCourses[onlineCourseIndex].date, '.education-entry', 0],
                ['HTMLonlineURL', education.onlineCourses[onlineCourseIndex].url, '.education-entry', 0]
            ];

            if (onlineCourseIndex === 0) {
                onlineCourseArray.unshift(['HTMLonlineClasses', '', '.education-entry', 0]);
            }
            for (var arrIndex=0; arrIndex<onlineCourseArray.length; arrIndex++) {
                replaceAppend(onlineCourseArray[arrIndex][0], onlineCourseArray[arrIndex][1], onlineCourseArray[arrIndex][2], onlineCourseArray[arrIndex][3]);
            }
        }

    };
    education.display();
    
    //******************************** Map *********************************************

    replaceAppend('googleMap', '', '#mapDiv', 0);

 

});
