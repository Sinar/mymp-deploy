/* Example production configuration file
 */

module.exports = {

    server: {
        port: 3000,
    },

    hosting_server: {
        host:       'popit.sinarproject.org',
        base_url:   'http://popit.sinarproject.org:3000',
        email_from: 'PopIt <popit@popit.sinarproject.org>', 

        // This is a token asked for on the un-publicised create new instance page. It
        // is a simple way to let only invited people create instances.
        create_instance_invite_code: "XXX - change me - XXX",
    },
    instance_server: {
        base_url_format: "http://%s.popit.sinarproject.org:3000",
        cookie_secret: '8^m$EdM`];bu)Fr9Z/L#',
    },
    email: {
        transport:         'SMTP',
        // See https://github.com/andris9/Nodemailer for config - empty fine for localhost:25
        transport_options: { },
    },
    
};
