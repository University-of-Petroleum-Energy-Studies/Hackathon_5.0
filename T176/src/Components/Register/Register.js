import React, { useState } from 'react'
import './Register.css'

import { auth, db } from '../../firebase';
import { Link, useHistory } from 'react-router-dom';

const Register = () => {

    const history = useHistory();

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [khasra, setKhasra] = useState('');
    const [address, setAddress] = useState('');
    const [aadhar, setAadhar] = useState('');
    const [contact, setContact] = useState('');

    const validate = (e) => {
        e.preventDefault();

        if (khasra.length !== 8) alert('Khasra No. must be of 8 digits !!');

        else if (aadhar.length !== 12) alert('Aadhar must be of 12 digits !!');

        else if (contact.length !== 10) alert('Contact must be of 10 digits');

        else {
            alert('All the provided informations are correct ! Good to Go ... 😄')
            // document.querySelector('.register__button').disabled = false;
        }

    }

    const register = e => {
        e.preventDefault();

        db.settings({
            timestampsInSnapshots: true
        });
        db.collection("FarmersInfo").add({
            email: email,
            khasra: khasra,
            address: address,
            aadhar: aadhar,
            contact: contact
        });

        auth
            .createUserWithEmailAndPassword(email, password)
            .then((auth) => {
                if (auth) {
                    history.push('/buyorsell')
                }
            })
            .catch(error => alert(error.message))

    }

    const login = () => {
        history.push('/login')
    }


    return (
        <div className="register">

            <div className="wrapper fadeInDown">
                <div id="formContent">
                    <h2 class="active"> Sign Up </h2>

                    <div class="fadeIn first">
                        <img src="https://image.freepik.com/free-vector/isometric-farming-concept_1284-36362.jpg" id="icon" alt="User Icon" />
                    </div>

                    <form>
                        <input type="email" id="login" class="fadeIn second" name="login" placeholder="Enter Email" value={email} onChange={e => setEmail(e.target.value)} />
                        <input type="password" id="password" class="fadeIn third" name="login" placeholder="Enter Password" value={password} onChange={e => setPassword(e.target.value)} />

                        <input type="text" placeholder='Enter Khasra No.' value={khasra} onChange={(e) => setKhasra(e.target.value)} />
                        <input type="text" placeholder='Enter Address' value={address} onChange={(e) => setAddress(e.target.value)} />
                        <input type="text" placeholder='Enter Aadhar No.' value={aadhar} onChange={(e) => setAadhar(e.target.value)} />
                        <input type="text" placeholder='Enter Contact No.' value={contact} onChange={(e) => setContact(e.target.value)} />

                        <input onClick={validate} type="submit" class="fadeIn fourth" value="Validate" />


                        <input onClick={register} className='register__button' type="submit" value="Sign Up" />
                    </form>

                    <input onClick={login} type="submit" class="fadeIn fourth" value="Redirect to Sign In" />

                </div>
            </div>

        </div>
    )
}

export default Register
