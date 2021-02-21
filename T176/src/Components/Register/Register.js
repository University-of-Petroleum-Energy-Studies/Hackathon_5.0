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

    // const addData = e => {
    //     e.preventDefault();

    //     db.settings({
    //         timestampsInSnapshots: true
    //     });
    //     db.collection("FarmersInfo").add({
    //         email: email,
    //         khasra: khasra,
    //         address: address,
    //         aadhar: aadhar,
    //         contact: contact
    //     });
    // }

    return (
        <div className="register">

            <div className="wrapper fadeInDown">
                <div id="formContent">
                    <h2 class="active"> Sign Up </h2>

                    <div class="fadeIn first">
                        <img src="https://image.freepik.com/free-vector/isometric-farming-concept_1284-36362.jpg" id="icon" alt="User Icon" />
                    </div>

                    <form>
                        <input type="text" id="login" class="fadeIn second" name="login" placeholder="Enter Email" value={email} onChange={e => setEmail(e.target.value)} />
                        <input type="text" id="password" class="fadeIn third" name="login" placeholder="Enter Password" value={password} onChange={e => setPassword(e.target.value)} />

                        <input type="text" placeholder='Enter Khasra No.' value={khasra} onChange={(e) => setKhasra(e.target.value)} />
                        <input type="text" placeholder='Enter Address' value={address} onChange={(e) => setAddress(e.target.value)} />
                        <input type="text" placeholder='Enter Aadhar No.' value={aadhar} onChange={(e) => setAadhar(e.target.value)} />
                        <input type="text" placeholder='Enter Contact No.' value={contact} onChange={(e) => setContact(e.target.value)} />


                        <input onClick={register} type="submit" class="fadeIn fourth" value="Sign Up" />
                    </form>

                </div>
            </div>

        </div>
    )
}

export default Register
