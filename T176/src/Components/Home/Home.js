import React from 'react'
import './css/Home.css'

const Home = () => {

	return (
		<div className='Home'>

			<div className="home__nav">
				<h3><a href="/login" style={{ color: 'black' }}>Login</a></h3>
				<h3><a href="/register" style={{ color: 'black' }}>Register</a></h3>
			</div>



			{/* Header */}

			<div id="header">
				<i class="fas fa-tractor fa-4x"></i>
				<h1>Welcome to AgriVend.</h1>
				<p>AgriVend – a one step solution for farmers
				<br /> to buy goods and sell crops.</p>
			</div>

			{/* Main */}
			<div id="main">

				<header className="major container medium">
					<h2>AgriVend is a webapp through which farmers can sell crops to and buy
					equipment directly from other merchants without any third-party mediation. To avoid price inflation
					and maintain regularised selling, the app validates any purchase through the use of MSP for pricing
					and the buyer must adhere to it. The app also incorporate payment authentication which help both
					parties avoid extra middleman costs and helps in creating of a completely self – independent virtual
					market space to empower both the buyer and seller.
					</h2>

				</header>

				<div className="box alt container">

					<section className="feature left">
						<a href="/buy" className="image icon solid fa-shopping-cart"><img src="images/pic01.jpg" alt="" /></a>
						<div className="content">
							<h3>Buy Goods</h3>
							<p>We provide all essential equipments, fertilizers, pesticides, and varieties of seeds
							  crucial for a productive output.</p>
						</div>
					</section>

					<section className="feature right">
						<a href="#" className="image icon solid fa-handshake"><img src="images/pic02.jpg" alt="" /></a>
						<div className="content">
							<h3>Sell Crops</h3>
							<p>We help you get best value for your crops by ensuring prices with Minimum Support Price.</p>
						</div>
					</section>

				</div>


				<footer className="major container medium">
					<h3>How are we different</h3>
					<p>We are creating a safe, regulated and fully virtual platform which acts as a self-
					independent marketplace exclusively for farmers. Through the use of MSP, we are making farmers
					aware of the true market value for their goods and help him/her in creating a stronger negotiating
					position for self.</p>

				</footer>

			</div>

			{/* Footer */}
			<div id="footer">
				<div className="container medium">

					<header className="major last">
						<h2>Questions and Feedback</h2>
					</header>

					<p>Tell us how we can improve more and provide you better services.
					<br /> Constructive criticism and positive feedback are appreciated.</p>

					<form method="post" action="#">
						<div className="row">
							<div className="col-6 col-12-mobilep">
								<input type="text" name="name" placeholder="Name" />
							</div>
							<div className="col-6 col-12-mobilep">
								<input type="email" name="email" placeholder="Email" />
							</div>
							<div className="col-12">
								<textarea name="message" placeholder="Message" rows="6"></textarea>
							</div>
							<div className="col-12">
								<ul className="actions special">
									<li><input type="submit" value="Send Message" /></li>
								</ul>
							</div>
						</div>
					</form>

				</div>
			</div>





		</div>
	)
}

export default Home
