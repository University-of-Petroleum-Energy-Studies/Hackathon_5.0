import React from 'react'
import './Login.css'

import { auth, provider } from '../../firebase';

const Login = () => {

    const signIn = () => {
        auth.signInWithPopup(provider)
            .catch(err => alert(err.message));
    }
    return (
        <div className='login'>

            <div className="wrapper fadeInDown">
                <div id="formContent">
                    <h2 class="active"> Sign In </h2>

                    <div class="fadeIn first">
                        <img src="https://image.freepik.com/free-vector/modern-organic-farm-ranch-yard-isometric_1441-3221.jpg" id="icon" alt="User Icon" />
                    </div>

                    <form>
                        <input type="text" id="Username" class="fadeIn second" name="login" placeholder="Username" />
                        <input type="text" id="password" class="fadeIn third" name="login" placeholder="password" />
                        <input type="submit" class="fadeIn fourth" value="Log In" />
                        <input type="submit" class="fadeIn fourth" value="Log In with Google" onClick={signIn} />
                    </form>

                </div>
            </div>

        </div>
    )
}

export default Login
