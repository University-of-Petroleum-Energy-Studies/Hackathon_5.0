import React from 'react'
import './Register.css'

const Register = () => {
    return (
        <div className="register">

            <div className="wrapper fadeInDown">
                <div id="formContent">
                    <h2 class="active"> Sign Up </h2>

                    <div class="fadeIn first">
                        <img src="https://image.freepik.com/free-vector/isometric-farming-concept_1284-36362.jpg" id="icon" alt="User Icon" />
                    </div>

                    <form>
                        <input type="text" id="login" class="fadeIn second" name="login" placeholder="Username" />
                        <input type="text" id="password" class="fadeIn third" name="login" placeholder="password" />
                        <input type="submit" class="fadeIn fourth" value="Log In" />
                    </form>

                </div>
            </div>

        </div>
    )
}

export default Register
