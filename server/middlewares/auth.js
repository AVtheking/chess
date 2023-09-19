const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (token === "your_testing_token") {
            req.user = null; // Set req.user to null for testing purposes
            req.token = token; // Set the token for testing purposes
            return next(); // Continue to the route handler without authentication
        }

        if (!token) {
            return res.status(401).json({ msg: "No auth token ,access denied" });

        }
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) {
            return res.status(401).json({ msg: "Token verification failed! authentication denied", },);
        }
        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};
module.exports = auth;