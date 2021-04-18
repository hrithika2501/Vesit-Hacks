var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var app = express();
var session = require('express-session');
var bodyParser = require('body-parser');
const moment = require('moment');
var nodemailer = require('nodemailer');
var studentID;
app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));
app.use(bodyParser.urlencoded({
    extended: false
}));
app.use(bodyParser.json());

app.use(express.static('public'));
app.set('view engine', 'ejs');

var con = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "",
    database: "eventsmanagement",
    multipleStatements: true
});

// ------------------------------Login page------------------------------
app.get('/login', function (req, res) {
    res.render("login");
});
var FCID = "";
var selected = "";
app.post('/login', function (req, res) {
    var username = req.body.email;
    var password = req.body.password;
    console.log(username, password);
    if (req.body.email == '2019sonu.zope@ves.ac.in' && req.body.password == 'sonuzope') {
        console.log('Admin Login');
        req.session.admin = true;
        res.send("Admin");
    } else {
        if (req.body.optradio === 'student') {
            var sql = "SELECT * FROM `students` WHERE Email = '" + username + "' AND Password = '" + password + "'";
            con.query(sql, function (error, results) {
                if (error) throw error
                if (results.length > 0) {
                    studentID = results[0]['StudentId'];
                    req.session.loggedin = true;
                    if (results[0]['commID'] !== '5' || results[0]['CID'] !== '6'){
                        selected = true;
                    }
                    res.send('logged in');
                } else {
                    res.send('Wrong Credentials!');
                }
                res.end();
            });
        } else if (req.body.optradio === 'faculty') {
            var sqli = "SELECT * FROM `faculty` WHERE `Email`='" + username + "' AND `Password` = '" + password + "'";
            con.query(sqli, function (error, results) {
                if (error) throw error
                if (results.length > 0) {
                    selected = true;
                    req.session.loggedin = true;
                    FCID = results[0]['CID'];
                    req.session.faculty = true;
                    if (results[0]['CID'] !== '6'){
                        selected = true;
                    }
                    res.send('success');
                } else {
                    res.send('Wrong Credentials!');
                }
                res.end();
            });
        }
    }
});
// ---------------------------change password--------------------------
app.post('/changepassword', function (req, res) {
    res.redirect('change');
});

app.get('/change', function (req, res) {
    res.render('change');
});

app.post('/verifydetails', function (req, res) {
    var oldpass = req.body.oldpassword;
    var newpass = req.body.newpassword;
    console.log(req.body.type);
    console.log(req.body.email);
    if (req.body.type === 'student') {
        con.query("SELECT  `Email`, `Password` FROM `students` WHERE `Email` = '" + req.body.email + "'", function (err, stu) {
                if (err) throw err;
                else {
                    console.log(stu[0]['Password']);
                    if (oldpass === stu[0]['Password']) {
                        con.query("UPDATE `students` SET `Password`='" + newpass + "' WHERE `Email` = '" + req.body.email + "'", function (stud) {
                            if (err) throw err;
                            else {
                                res.send('changed');
                            }
                        });
                    } else {
                        res.send('incorrect');
                    }
                }
            });
    }
    else if (req.body.type === 'faculty') {
        con.query("SELECT  `Email`, `Password` FROM `faculty` WHERE `Email` = '" + req.body.email + "'", function (err, stu) {
                if (err) throw err;
                else {
                    console.log(stu[0]['Password']);
                    if (oldpass === stu[0]['Password']) {
                        con.query("UPDATE `faculty` SET `Password`='" + newpass + "' WHERE `Email` = '" + req.body.email + "'", function (stud) {
                            if (err) throw err;
                            else {
                                res.json('password changed');
                            }
                        });
                    } else {
                        res.json('incorrect password');
                    }
                }
            });
    }
});
//   ------------------------------Logout------------------------------
app.get('/logout', function (req, res) {
    req.session.destroy();
    res.redirect('/login');

})

// ------------------------------register-event display-------------------
var events;
app.get('/home', function (request, response) {
    var sql = "SELECT * FROM `events` WHERE 1";
    con.query(sql, function (err, reqq) {
        if (err) throw err
        events = [];
        const months = {
            0: 'January',
            1: 'February',
            2: 'March',
            3: 'April',
            4: 'May',
            5: 'June',
            6: 'July',
            7: 'August',
            8: 'September',
            9: 'October',
            10: 'November',
            11: 'December'
        }
        const days = [
            'Sun',
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat'
        ]
        for (let i = 0; i <= (reqq.length) - 1; i++) {
            var x = reqq[i];
            var bol = x['Approval'] === 1;
            if (bol === true) {
                events.push(x);
                var start = new Date(x['Start_Date']);
                var end = new Date(x['End_Date']);
                const syear = start.getFullYear()
                const sdate = start.getDate();
                const smonthName = months[start.getMonth()];
                const sdayName = days[start.getDay()];
                const formatted = `${sdayName}, ${sdate} ${smonthName} ${syear}`;
                const shours = start.getHours();
                const sminutes = start.getMinutes();
                // end date
                const eyear = end.getFullYear()
                const edate = end.getDate();
                const emonthName = months[end.getMonth()];
                const edayName = days[end.getDay()];
                const formatted2 = `${edayName}, ${edate} ${emonthName} ${eyear}`;
                const ehours = end.getHours();
                const eminutes = end.getMinutes();
                var sampm;
                var eampm;
                if (shours < 12) {
                    sampm = 'am';
                } else if (shours >= 12) {
                    sampm = 'pm';
                }
                if (ehours < 12) {
                    eampm = 'am';
                } else if (ehours > 12) {
                    eampm = 'pm';
                }
                const formatted1 = `${shours}:${sminutes} ${sampm}`;
                x['SDate'] = formatted;
                x['STime'] = formatted1;
                const formatted3 = `${ehours}:${eminutes} ${eampm}`;
                x['EDate'] = formatted2;
                x['ETime'] = formatted3;
            }
        }
        response.send(events);
    });
});

// ---------------------------------Register in an event ---------------------------------
app.post('/register', function (req, res) {
    var requestedid = req.body.id;
        var sqlit = "INSERT INTO `event_list`(`StudentID`, `EventID`) VALUES ('" + studentID + "','" + requestedid + "')";
        con.query(sqlit, function (err) {
            if (err) throw err;
            else {
                res.send("Record inserted");
            }
        });
});
var dict = {};
// -------------------------------------Admin------------------------------------------------------
app.get('/admin', function (req, res) {
    var sql = "SELECT * FROM `branch` WHERE 1";
    con.query(sql, function (err, b) {
        if (err) throw err;
        else {
            var sqli = "SELECT * FROM `commitee` WHERE 1";
            con.query(sqli, function (err, c) {
                if (err) throw err;
                else {
                    var sqlit = "SELECT * FROM `student_body` WHERE 1";
                    con.query(sqlit, function (err, s) {
                        if (err) throw err;
                        else {
                            console.log('yayyy');
                        }
                        dict['branch'] = b;
                        dict['comm'] = c;
                        dict['sb'] = s;
                        res.json(dict);
                    });
                }
            });
        }
    });
});

app.post('/branch', function (req, res) {
    branch = req.body.branch;
    if (branch != "Department") {
        con.query("SELECT * FROM faculty WHERE BranchID = '" + branch + "' ", (err, result) => {
            if (err) {
                console.log(err);
                res.send({
                    "error": true
                });
            } else {
                console.log(result);
                res.send(result);
            }
        });
    }
});


//----------------------------------INSERT DEPARTMENT FACULTY-----------------------//
app.get('/facultydep', function (req, res) {
    var b = "";
    var c = "";
    var s = "";
    var sql = "SELECT * FROM `branch` WHERE 1";
    con.query(sql, function (err, b) {
        if (err) throw err;
        else {
            var sqli = "SELECT * FROM `commitee` WHERE 1";
            con.query(sqli, function (err, c) {
                if (err) throw err;
                else {
                    var sqlit = "SELECT * FROM `student_body` WHERE 1";
                    con.query(sqlit, function (err, s) {
                        if (err) throw err;
                        else {
                            console.log('yayyy');
                        }
                        var conco = b.concat(c);
                        res.json(conco.concat(s));
                    });
                }
            });
        }
    });
});

app.post('/facultydep', function (req, res) {
    console.log(req.body);
    con.query("INSERT INTO `faculty`(`Name`, `Email`,`Password`,`Gender`, `DOB`, `Phone`, `RoleID`, `BranchID`, `CID`) VALUES ('" + req.body.name + "','" + req.body.email + "','" + req.body.Password + "','" + req.body.Gender + "','" + req.body.date + "','" + req.body.Phone + "','" + req.body.RoleID + "','" + req.body.Branch + "','" + req.body.Commitee + "')", (err, result) => {
        if (err) {
            console.log(err);
            res.send({
                "error": true
            });
        } else {
            console.log('yayyyyyy');
            res.send("yayyyy");
        }
    });
});

// --------------------------------------add event-------------------------------------------
app.get('/event', function (req, res) {
    var b = "";
    var c = "";
    var s = "";
    var sql = "SELECT * FROM `branch` WHERE 1";
    con.query(sql, function (err, b) {
        if (err) throw err;
        else {
            var sqli = "SELECT * FROM `committee` WHERE 1";
            con.query(sqli, function (err, c) {
                if (err) throw err;
                else {
                    var sqlit = "SELECT * FROM `student_body` WHERE 1";
                    con.query(sqlit, function (err, s) {
                        if (err) throw err;
                        else {
                            console.log('yayyy');
                        }
                        var conco = b.concat(c);
                        res.json(conco.concat(s));
                    });
                }
            });
        }
    });
});

app.post('/event', function (req, res) {
        var name = req.body.name;
        var des = req.body.des;

        var start_time = req.body.start_time;
        var end_time = req.body.end_time;

        var sb = req.body.sb;
        var comm = req.body.comm;
        var branch = req.body.branch;
        var level = req.body.level;
        var year = req.body.year;

        res.send('Successful');

        con.connect(function (err) {
            if (err) throw err;
            var sql = "INSERT INTO events (Name, Description, CID, Start_Date, End_Date, e_year, BranchID, LevelID, commID, Approval ) VALUES ('" + name + "', '" + des + "','" + sb + "', '" + start_time + "','" + end_time + "', '" + year + "', '" + branch + "', '" + level + "', '" + comm + "', '0')";
            con.query(sql, function (err, result) {
                if (err) throw err;
                console.log("1 record inserted");
                res.end();
            });
        });


    //Mail

    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'ecelleventmanagement@gmail.com',
            pass: '@Pikachu123'
        }
    });
    if (level === "1") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="1" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "2" && branch === "2") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="3", BranchID="2" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "2" && branch === "3") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="3", BranchID="3" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "2" && branch === "4") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="3", BranchID="4" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "2" && branch === "5") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="3", BranchID="5" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "2" && branch === "6") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="3", BranchID="6" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "2" && branch === "7") {
        var emails = 'SELECT Email FROM faculty WHERE RoleID="3", BranchID="2" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "3" && sb === "2") {
        var emails = 'SELECT Email FROM faculty WHERE CID="2" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "3" && sb === "3") {
        var emails = 'SELECT Email FROM faculty WHERE CID="3" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "3" && sb === "4") {
        var emails = 'SELECT Email FROM faculty WHERE CID="4" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "3" && sb === "5") {
        var emails = 'SELECT Email FROM faculty WHERE CID="5" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    } else if (level === "3" && sb === "6") {
        var emails = 'SELECT Email FROM faculty WHERE CID="6" ';
        var to_list = [];
        con.query(emails, function (err, email, fields) {
            console.log(email);
            for (k in email) {
                to_list.push(email[k].Email);
                console.log(to_list);
            }
        });


    }


    var mailOptions = {
        from: 'ecelleventmanagement@gmail.com',
        to: to_list,
        subject: 'Sending Email using Node.js[nodemailer]',
        html: "<h2>Name: </h2>" + req.body.name + "<h2>Description: </h2>" + req.body.des + "<h2>Start Date: </h2>" + req.body.start + "<h2>End Date:</h2> " + req.body.end + "<h2>Student Body:</h2>" + req.body.sb + "<h2>Commitee: </h2>" + req.body.comm + "<h2>Branch:</h2>" + req.body.branch + "<h2>Year: </h2>" + req.body.year + '<p><a href="http://localhost:3000/approve">Approve</a></p>' + '<p><a href="http://localhost:3000/decline">Decline</a></p>'
    };
    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }


    });
    }
)

app.get("/approve", function (req, res) {

    var sqlit = "UPDATE events SET Approval = '2' WHERE Approval = 0";
    con.query(sqlit, function (err) {
        if (err) throw err;
        else {
            console.log("Approved");
            res.send("Approved");
        }
    });
});

app.get("/decline", function (req, res) {

    var sqlit = "UPDATE events SET Approval = '1' WHERE Approval = 0";
    con.query(sqlit, function (err) {
        if (err) throw err;
        else {
            console.log("Declined");
            res.send("Declined");
        }
    });
});

// -----------------------------Add department-----------------------------------
app.post('/submit', function (req, res) {
    var add = req.body.add;

    var sql = "INSERT INTO branch (BranchName) VALUES ('" + add + "')";
    con.query(sql, function (err, result) {
        if (err) throw err;
        console.log("1 record inserted");
        res.send('Successful');
    });
});



app.post('/submit1', function (req, res) {
    var level = req.body.level;
    var add = req.body.add;
    var sql = "INSERT INTO commitee (Name,level) VALUES ('" + add + "', '" + level + "')";
    con.query(sql, function (err, result) {
        if (err) throw err;
        console.log("1 record inserted");
        res.send('Successful');
        res.end();
    });
});

app.post('/submit2', function (req, res) {

    var add = req.body.add;
    var sql = "INSERT INTO student_body (name) VALUES ('" + add + "')";
    con.query(sql, function (err, result) {
        if (err) throw err;
        console.log("1 record inserted");
        res.send('Successful');
        res.end();
    });
});

// --------------------------------------add committee-------------------------------------------
app.get('/CommiteMembers', function (req, res) {
    var b = "";
    var c = "";
    var s = "";
    var sql = "SELECT * FROM `branch` WHERE 1";
    con.query(sql, function (err, b) {
        if (err) throw err;
        else {
            var sqli = "SELECT * FROM `commitee` WHERE 1";
            con.query(sqli, function (err, c) {
                if (err) throw err;
                else {
                    var sqlit = "SELECT * FROM `student_body` WHERE 1";
                    con.query(sqlit, function (err, s) {
                        if (err) throw err;
                        else {
                            console.log('yayyy');
                        }
                        res.json({
                            "branch": b,
                            "committee": c,
                            "stud_body": s
                        })
                        //var conco = [b].push([c]);
                        //res.json(conco.push([s]));
                        //res.send([b,c,s])
                    });
                }
            });
        }
    });
});

app.post('/CommiteeMembers', function (req, res) {
    console.log(req.body);
    con.query("INSERT INTO `students`( `Name`, `Email`, `Password`, `Gender`, `DOB`, `Phone`, `Year`, `CID`, `commID`, `BranchID`,`LevelID`) VALUES ('" + req.body.name + "','" + req.body.email + "','" + req.body.Password + "','" + req.body.Gender + "','" + req.body.date + "','" + req.body.Phone + "','" + req.body.Year + "','6','" + req.body.CommID + "','" + req.body.BranchID + "','" + req.body.LevelID + "')", (err, result) => {
        if (err) {
            console.log(err);
            res.json({
                "error": true
            });
        } else {
            console.log('yayyyyyy');
            res.send("yayyyy");
        }
    });
});

app.get('/modifysb', function (req, res) {
    var sql = "SELECT `students`.*, `student_body`.`CID`, `student_body`.`name` FROM `students` JOIN `student_body` ON `students`.`CID` = `student_body`.`CID`";
    con.query(sql, function (err, modi) {
        if (err) throw err;
        else {
            res.send(modi);
        }
    });
});

app.post('/modifysb', function (req, res) {
            if(FCID !== 6){
            con.query("UPDATE `students` SET `CID`='"+FCID+"' WHERE `StudentId` = '"+req.body.studentID+"'", function (err) {
               if (err) throw err;
               else{
                   res.send('success');
               } 
            });
            }else{
                console.log("denied");
                res.send('Denied');
            }
});

// ----------------------port--------------------------------------------
app.listen(5000,'192.168.43.104', function () {
    console.log('Listening to port 5000');
});