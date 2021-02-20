var currentQuestion = 0;
var score = 0;
var totQuestions = questions.length;

var container = document.getElementById('quizContainer');
var questionEl = document.getElementById('question');
var opt1 = document.getElementById('opt1');
var opt2 = document.getElementById('opt2');
var opt3 = document.getElementById('opt3');
var opt4 = document.getElementById('opt4');
var nextButton = document.getElementById('nextButton');
var resultCont = document.getElementById('result');

function loadQuestion (questionIndex) {
	var q = questions[questionIndex];
	questionEl.textContent = (questionIndex + 1) + '. ' + q.question;
	opt1.textContent = q.option1;
	opt2.textContent = q.option2;
	opt3.textContent = q.option3;
	opt4.textContent = q.option4;
};

function loadNextQuestion () {
	var selectedOption = document.querySelector('input[type=radio]:checked');
	if(!selectedOption){
		alert('Please select your answer!');
		return;
	}
	var answer = selectedOption.value;
	score += (5-answer);
	// if(questions[currentQuestion].answer == answer){
	// 	score += 5;
	// }
	selectedOption.checked = false;
	currentQuestion++;
	if(currentQuestion == totQuestions - 1){
		nextButton.textContent = 'Finish';
	}
	if(currentQuestion == totQuestions){
		container.style.display = 'none';
		resultCont.style.display = '';

		if(score<10)
		{
			resultCont.textContent = 'Your Score: \n' + score +"\n" +'Avail Medical Facility';
		}

		else if(score<=20 && score>10)
		{
			resultCont.textContent = 'Your Score: \n' + score +"\n" +'Doctor Needed';
		}
		
		else if(score<=30 && score>20)
		{
			resultCont.textContent = 'Your Score: \n' + score + "\n" +'You Will Be Fine Soon';
		}

		else if(score>30 && score<=40)
		{
			resultCont.textContent = 'Your Score: \n' + score + "\n" +'You are perfectly fine';
		}
		return;
	}
	loadQuestion(currentQuestion);
}

loadQuestion(currentQuestion);