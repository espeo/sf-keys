#!/bin/sh
. /opt/farm/scripts/init

/opt/farm/scripts/setup/extension.sh sf-passwd-utils

echo "checking custom system groups"
/opt/farm/ext/passwd-utils/create-group.sh espeodev
/opt/farm/ext/passwd-utils/create-group.sh espeoadm


ADM="tklim fchmarzynski durbanski burbaniak tliberski"
if [ ! -s /etc/local/.config/devops.disable ]; then
	for user in $ADM; do
		/opt/farm/ext/passwd-utils/create-user.sh $user $user
		/opt/farm/ext/passwd-utils/add-groups.sh $user espeoadm adm docker www-data circleci jenkins
	done
fi


addkey="/opt/farm/ext/passwd-utils/add-key.sh"
key=`/opt/farm/ext/keys/get-ssh-management-key-content.sh $HOST`
$addkey root inline "$key"


echo "checking for known accounts and installing associated keys"
$addkey adys            inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDOlivfJ6hbcaSS3POPBdOH0dvChwNV1TIEfAqKcw5BD2o3K2aLqZUVH88tQKHBBpaZ10M4asFvlZyv1oSRhiwz41g+gqYdc9ll8fe9Nsl83bQQlN6UGuM2+6bXEfKDLGlghbn+e3Zs8+auTD5WDx0zLt1oY6hLQ5etlxN5lsZIFRSrw1AQR1Lb0UrqG4VrsYolBPd5rEHJZrnTuT7RtEvlDU+9B4YhjT1JpudjeKqULgPTCpuE7KJ1FIRZJlL5/I9Zw+LzV+Bd+xwqhjRcQMiuYjGPwl9Fgj8qAfJO3vaw1eimLFBE3sDLg0jrntra0xfLmz8PfWikHXdj9lcIbJ0eVUUoe6l8Arg40K0y5M/ieGxm6GbO3MkQ9XTRLThJ8JJWJn1ACbbiVGBxlfKhAhRZxa2DZ3JAA0+nmOS6BWxdBwKvA2B0hEkQsSSqGpeJNVYf0rG1OOCq5LbF9lUc9KYjmjd6PlbMiTcn1+F9W5HgaTnHFN3HMH0D0YDyLocA2UovwbdiOeIAJSUecEIDAoJGikA5v8g7GRXaHH1wh3TfAP9vS3cn5olJDKIJUBa83xk52LOT1gDEpJdmDg1IWo+o2nj357Q3Czyg0FNuWS5Rt/WaYJTL/pIPokUozif2ob1i/x1yHMtYvIheUNImxzkA5SETUppU34sQBCpYKzBsmQ== ada.dys@espeo.eu"
$addkey amakowska       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC005UNvR4VStx/+eu40tHKksAg6fB4hhvDbdA+BVcof4Z4SPVemGxcxiItqp+TF7SsAIl7GYA0c0OTZUjHHJkiYgzbATatdVVtmXBYkjsB73dHeSi7iU3cAxbapwaRH2pwvszmzP6Y8UuD5eExU2gas63qXDMePMWkhHEyTPLTDFJfYMYA4byr4XJaEMnx++xnEgrJUrQl2XZfu+ozUhtpzKtUhORZxoB5SPv8VhEGA0USPGpjXv1ky9HBvdjWsOOkP2ndHHmExj2G9lQjgkhobKwI4Fq0tqaC8furfvJkaE09oSq7GGEyRyva0gkktpiFdqU++f85TKK4W6tJbza/ amakowska@espeo-amakowska"
$addkey amakowska       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRGsvqzIKY03h4NpRakylQkwFqT23dR0CV9xcXhJ8rAP4lgtFfs0I2HdJ/utHQtt0FXhYptkOxhp2zH8Mqw0xzwBWArxQC43S9jSGU1zcIgAmikeNkwEB/IOCfIxODyt60Ce5BGitkK9wDaO5LKowCYBB8LgkcuQnxVbgeOT2hPrM1tFqwuoBXfX1cwBIdbhldnNv0uAIBBsaLT0+CFR74bi4iGKznj6HdqTNrZFSFuvWqQMkND7QGq/2x9XdTwO8o8hjER3Vg5RQhUwyk24DvcQ9WndvVYBj9WeIf0uKE4LKzS/xrFfWuLvAJ2/KeOUMCN5n3gdm4H98fl/iB240D amakowska"
$addkey bpasik          inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlDXpZO4YDfLxKSDKMjcZlByTghAV7PeBiFGxH6x/nT2FoPGnFv68SMcbC5M0A+ithdN5hSxTyt4aAyb5Mvv63sVlE4hD7P+OOkzi0+GukyZEXGR5aJmD2oaqwkK5ig7pHFUZJCwTgAUIdJpRJybQraRJ10SAHM3bJ8opGUuQKPIzdYPFyYknMGgHZEhneyJlQhogr60lK4IOzszLG81PQdanzrE4zQjHJbCqg6K0yW94vzA/+RkqyMvRYpVTAIvz7NWEbTIAaFjYCqg+RU0qjKrSWGLCWc6B550Gld69c7g9gmacwHnbkWFk8OxDBw7TLpLeUUy0ru+eKCrvUIWnn hya@hyazeh"
$addkey bpasik          inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8U1ZkaBbr/rFbY5b1vcWK5e/JJg7CJsiDqQvRdYDsENjo5yb4xSoYPd11vx8bAKrIc8RLqcWuJVPGSqetjZijD6j9iXwMF+SeQ/ng30B64ddibSQYsFQMaCSw4TcF7GQRungvYEbXvrwfxzmVHDzLMT96nydo2J8XP8ckjMvLiYGb3M1xio2/q0rrccX33C/oDxOwN0LrYDBMmXlS8NAOP0Pq7qFYiS7VvATTqRyUYFM5c/i17jcj/k5FeAS+/p6rqWY22lSJQuQ44aA99rmM7lcVPV8k9+mfZLZgvUltT28uo5VdGs25/9/JU3nOHxEbsWPXRdjF2UKm81H8zhfj bpasik@bpasik"
$addkey btelesinski     inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJGX8jUNufgt3EFOz6l6ltoB7x6fbE3KJ+oMGzJ3++cJqLiWC1cpbZyAcol8wdgxAT1bh59n6XJdgcUlzu8n/Q+Zk6iAthfrpmzGy/03uS/jlAFIfmyefo9VeqbGzIG+jbkH9h4umqrsoHjIKueIvkjtlWvjzFwMban8J9ED4hf9Th1AoEF4tEajMXKXE7aXSkrui1N66HwqaTi1wa8sbAQasqDr1oxqbNxokWg4lpaDhW6ejESpcF97nc6CVgkHB0yZK2L2a15joAhw8PwDkN2KrVQYvAo6Wax42bseqAbe3NaJof42JJDR3xmB8/iQjfJr1DIlBsOr3tG/r389Lz bartosz.telesinski@espeo.eu"
$addkey burbaniak       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBJRyAm3kX5ym8qY2TbrXxXSMpkei6/S7rHp4qgYy4duRUsN4h5wUclAtvbE0nX1MYgFPpscG4gWByYC6I9JT4t3UA3WCScO3mY82fIF4SaMEGB3G0JlacIExS9ALO3d4C198MO0sIaW1JJkAiaUoTeZ2erMAk6BHphBWdcp/QjYYFNDWnDenvNcxy120Dhw9z4laHm+KtaicAJ1nWk8IvlZcdb3WtpllWZrsBzXIy8iW/nHLJa/yqna5Fud/LF6rqLO6vxlfohjxRjVTI2hXFzhSidZRXJcCE7vpwiVoy0XFzSKfmr7VwxN016Bg/U3QXgSVZ4qX6fPYMbRtyNSCt bartoszurbaniak@mbp"
$addkey durbanski       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZV+EMwqLHc+kZFDc8K53q8qH4hagGJuUvNDZdmqVJMyw+cJnt3PtRCSTj0Ud+N5FtvnlpKcB4gdWTJl+QFfH9F9Dg+80e83007KgTDLaC4THcoSqKiAkeBtlAuQQQC+ANH87td1I0/EOncnaVRjA8T6rTUIix8rx74W3Utv3V5J/jwbnZPiRgO2B6Gczc33E1sTM5JXuMA2wV3NNB3um7mEsSGgc4hWbdVVw7OdaRzXrzd4OKckO7SK61Ga1ua7W2fcZ1mdcQQ8NQF708fFctZQruzx7/gOZPTaZRV1PHK+IgYVo2tKWgAhqQZBBQ9k7g2Go+97M+q8p2ywFTXKdP durbanski@espeo-urbanski"
$addkey durbanski       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgrbsmh3uMb/nIHlspqZ81AUGPOg3gJgbi5IYcSZ+y/epiz/tzqUnWquufQuosBuVAaQWhqecL6kW1MFghxj0HXxvYk6InqxjIiGmH3SjPMHZ52J2I1r8J+Dyje96i1B565U+f1n1EuAlkL5RZjQFyi1kxxvUSoua9rDUe89rgJAlTwAGu2oQp2088mVaO4022WYprM6v8vjlBOMLEwHzXRe/uBIZn5IEjv26LJgwA2rRyo/szjLrFnDSQFZ1xQWdtyyWZDiU6TevYAEtJiQThVSa9bIInhE9DwD41A/sy7m3nciiwXIH3Xk1NWqljMFOlIZNRCCPXRIhkJlS4DZGV test@espeo-durbanskiMac"
$addkey fchmarzynski    inline "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA090K5zQpeDKKLWq/S5wPsC6+zTh1+hnzxo/GrzuqkAMScgtvrGtcsXKoDOCq+iFmXyC51QN3DKksqqd4tVSMY77N1qHV1L8JbmcSMhh+CBpZXLasvRtb+6fUr+0zNvjsBSY9K6B+LWWY3Iu249POEw8BTno3l8rDlGXjg5WGc0sew6R5J7ft6hW1PO6FT+Jbp1yRGAOmQfnU15hOGHsP2hX06tSsiD3p/gUvL1fHlU80+Qh0ns8LzHV2ItccJDmL3unT+Q3ocND0zGFP77MSrihRozwxgdeRdMdoWr/gh59VX37++ZmPNXv1JPrAAzW/8TLDlG57FBWLmr+l591/Lw== fchmarzynski@espeo"
$addkey ksamborski      inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxyWVp2zs1UfRZJdKvDpUDRTdTE+JogjpTMKEL8S/ujF97y28ubqOcm+wfHsA9igp1lxaSkRMlKB6ap6MtcsSxnhd/s+6Yxhrw2pKktmlw7BfnvvXpqbxXL+V4HTjNSooglKl9VhdOIiLfIhnetgRTp7Bud8PEwq1BVLxPXcvF7tEqayFBTfhvDz1YgDxi2QWlXElXnbhnHHkFy7s6Bb/3QPbB+QD6w++j6cQT+LCyO5nlbeXDIrmOyzZJ2sbHOfaKHncgwuPro8cC1TC/TpZSoqD/LmKjd/xPon+Gy7FEe3X7GKiYLXivZAxspP6/bradEKU/uZrc4RYHj+aINwNh ksamborski@espeo-ksamborski"
$addkey kwedrowicz      inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDB4G8BnMKplzbiGQLv7tlCYoFfsiqfxAo86xg6C/xwKg8L6WfRml3DzlFUVKe4mjP8ka5CVj0HJnWrM3XZECSvFYg+SmXuRuC+BppV6qfyRU9Zu2vWE1Kh3i5s7AJG6Ukk2PuTPZl0uc2UpYiD+C6Xk1QCgGJv77cqwb6TZCUV2Hp4UbWgfrYbgJmbuMskPddEC0D8XiM3o5lZ3rV/1m0MCxSIw8KD1Kh4YAe2/Gui+V7LBXqe1Klxd5FrXDbAn5idNO4TGsv4KlrQjM8U77El8xJ16jTYMYH9bQpw6A0EeX1OiIce4QuPaGZCWqXLMBDlM4U+euRCcRb+E1Y1x3lR krzysztof.wedrowicz@espeo.eu"
$addkey lmazurek        inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZZ4XQ1XC1N5qgg6nnPNE6VblRLNJYr+CLHXmd8xAZVZrBPAKVAUWbavs/l0rV0yg1n+5slJBELfRU/+5BQalHlibHLJ3li20Bl5cSmY7K3zYoN5KjYG8NwEhgeA0rBdJs+ljlVMTrryn71hTnBdr9mKoc39pO12D4UEB84llU2EuhRu+yR1t4RNQu3CkX9aloHMQU66NTTrUsxVHLLE0uh3+rfBdRLrDAptTGMlTJibJLcGXHLg6RHw7cbW8gkI7L2HR+q5CNavOkmC/YBR1Y2rDc82/Gi8qK+d065XCj6YsY0PPdbYCBpM0TSwKPPIt5h/vbuUU1soimMvxUzG6p lukasz.mazurek@espeo.eu"
$addkey lszymanski      inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8zh50czAgWHK4FEMUBFPj/OH57RawR/y2ZLREJOSEekIWr+g04h2XYIKDwcWYl1T+LWVdsCQNOFbVjh6h//S88oQz9PQSo4WlpiE+ViYkX+qocbDl/wf1g2ybb5pCogd88MZkBdjar+IXM327gHykPpaC+MSQROuTSZ2NxoZbjQN2xz4i1xH2l3eA1k+C6rNicUbSrrwk2yWlciyis9usujJSGmSN0TZM8LekFi/VsAHYBRGBa238+gGVBdpoMh9II+SPs4E5SDaXufmnWlSIFnFFhWvLDNl8167QnwitcWBAmWXnaSwDbI7ItH3YCQbyrDRxkiV+UVsJ4FG9ouCX lszymanski@MacBook-Pro-Espeo.local"
$addkey mkomoch         inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD0Bev7wuzJbqmkkuTyw9wmN67akQFmuhfHsyXCQgfxBqq+Ol+MEtXX0Fp1TM2MxgvklQ6W7gf3gr5VvCXyVvVmX9kTXDEsYIhnMqJZIah3EtvqW6trQuoHys/Zd4EzVLAGhsjL9ou8r1k55sDlleduwdJf9dL9dBOlHgiqUJYJESJSywzZLGLObCzl23mN09Y7Ksw/ZdBu/9q7tpsH3eMy04NLa1Rk20GfRH9935NrGkDaM3UqJsrSIK0eyaYaLPeqyfYLpPBGYMkqsMqOnFXIjlta+xF0jsP+EdKteZ5xkxxsu8bLzgggf16TdfN1d2lgKTPOdaNKSwYp771vwuAt espeo@espeo-mk8"
$addkey mlatos          inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDILqd2siUCSVkHelJkSFw5b/TBqpVJ//6Bwl+/ZHghlYk2KxFy2sg8lL/4QFGd3ZGL52oA7CHPYFJMtymGEM9qRMpte9jviOTwfxx7ObGAeOfpZ5rMT+211BerqOTXA+SMtuSFZfIOcuk/utQACIfTSLeJiprW1iG41Z/sOmioX3UijO1EfOpokkLjAElF3Hg/OIa2oLhE9fwWOMJCCylyxw7/pudKMCt691rWr0NBP6dCCrGXLnnx7HL3dcNT9nh05021ZEFJt4t2kHxJiUT1OzzpEPP2JSer+Nbwo9+DyAds2p6UvFA2AXdc4OhcbErj5fXis3oCmvaeRLUsCdRN marcin@ml"
$addkey mtomaszewski    inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8QVFYHDIDqnZyRKuYyf8TGguBjODM7W2J4/Wt2oYDW2nL0Z7U8Ina0Uj6DyeNBTFB9MKC2CgCRYwN+prb1wvbbllRhIONj8ZaBF5/mkefDaAhQDV7eBrsiBNL9g8bllgiVl7JKIE8ggu1kSQANag+pKAk18QG+Ltm0izp1Z71q4ovtDGkTQrgJ8L5d6dFYMPR2RfWxvyi+Tvl906NP+MGfdR+mzkkpzgd4zFv01wvHBTDwUbB1U7y6IAcxIko7MJrVwDaY2B1duJWIy27IHAkooanAzgHfW5psa1avt5jJOiJYJh9loC/1ipKdmF9X8jKa6t5XQamWnn7zgg2F6S2DJ3S8O3nREXtF1j+XxYN4MIASss+QEkZg3g55qVDBbVLUQdpI1Wqyp5i/fpaJQHrQrhc1nwEURkDSqO5XyL6v0adzCJDy6ww0FmHtxPw5tPSJXIc/9jKHgYor5bqEKu4TWz9CrbrhRyihhQ6TCo78RXUNI0W0nTEFcmhCPCaIrH8S98F7y4tcjGDeRtBx2NQ542PTTJcl/dVLmMwi459pAUMyUslAu+In8SG8dJticJGFf0YQmK9ndl7caVgiZthk19USK6w3BoYPvNL6Xeq6ehhn1TyXaDm29czUv/xho1iLlN6yphzkcGTV4nri0iN2V0aRFFF7gd7y717VEmjAQ== maciej.tomaszewski@espeo.eu"
$addkey phorzycki       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCSeKhklL5pGN21gJCDpdX2+BYknhewqQor7Pj2sJrAEFDfVyKwecI84XsQGL8IpWpIovc0Gua7ZW3/JLwdyAloWowTZtiQpnZ6d8xLUB82Q5NTd+5jo1wZ5xnNdC7qQMhOa7+BhxZrlBKzDjke0dkTr48W7ST8VD2RwuLKNuXaUnflQPoIKNeUUJ9d+Uxyq+ZumkknYYZUGRcDRqhy5a6P/Ey0qFWOOGHtaxesmwni/bIkIlZIkDmIoH836iTDQmFA8ftmHrThM2hx0CvZgXxVrG6siC9mwIW2QCLp43v1hS/oiawlbvAHQ4tUSy2cGYLCaT8f1nPNRzDMEJbOgyN5 piotr.horzycki@espeo.eu"
$addkey rlempa          inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjorbM07bwL2W6ubETQYKAFU/6FPQvrLTDjr7hIMyrex1jNiYHFAwuiYqzZGOE4JJkBzReiV3K+Rives2K8PrRxxH/mJGO89/EQqH/TuS4s152Pr+r1NBodUO4Idb6a99zsX/7ZUk/eyrZ1PwgNaZdJ/BjNVIbxgtgKDPnpxzxcf5HPW5SOGwlFngG2NKaWhxXAyUpnE5LhzGJnAxF61b8HyLoWVmM6qAabgiQWJlvrgoyDHGkosrN+fYjXKODs4wckW5+gbGj1MTxvmgR4fkW4h20kIWwHbt5q0r7WdXos483y+49tTjc/8HlMhxHt56R3vSjA4iHV1lPN8hmm5uw72a5XuVQgGqANkElcnyi4FbeOid8L7tihPhpSbwiqox4NBYmy1HPQ5Su9MWFxOTdO/BDW0gSBy7YHQKjU/hOJJPK6jVdbHew6OHxZ4q37MOVJgrxOUrxRtAW07w5zaSy9tgzD9Wqi3BVECs8ZHJzYUWfyBLGDM4YKkePdZB4r4K/S7AEZ//wuh7CFsG0Afz7mIEZYrySNiolUF1qmDasq8Ojl001f1LsgXuQVFixkTILJNxde1mWCdh7eGBXhuFmDZpGZtC+w45J/A7LoIHV/uhYiUEeAQZ4iAgW5ZRaG0rqda6G8PfDeGfxdQepye6SljjxGnSQawutyI4lj+cmuQ== rlempa@3a.pl"
$addkey rlugowicz       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlx2RnE24lexgjigRvez1JzbHN1ifAPH8PBb8IXj5eQpXUJzFd4qsdcZkx0js56Y0XprMCWZ/jRc90AfQrRbKbWmy2N/u2y2Ctxb8xGav1D0gscAAgwY8P/9+L44SFc3HcVR1kfcPAAkFzPcRp9KMOaip/0vnPKIeSBbB5REdKW9XytMZN0fpYftgJ6Z2cDiIweeCkvqiFz6X2raJu/GF2sVkatYWfSfcLp1216kG9vel3d14ByrgmyBZElQ2zAbxXgISpSyEjcCT9qXqa4YeeSL8TD1+h0Q+GU94lXXX6DyzvmLTw48C5tpQQmovTC+JmiyFCIf0KNYV75uusq9qp radoslaw.lugowicz@espeo.pl"
$addkey signaczak       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl6Axq40+IHyTtIvl18FguMOgQkpDZ/LNQ9C3T8fuxT41WvT+LWiFrQYQh1WVNJXtIuCV6Wak+kUIysMgzV2aKoEDLonwkKCc2889nTZdi9kMzRwGzzr8Gqesk9N4/cE3KgR6j0ybHuUovVNkWOetoHqcX6+WQvkPmWp+YFYXnSULokZUPmNL+Xtse4ZN9kt6/VrafJhUbauNUuSTk2k5UsjKUjCDn8b8rT6mC8QsnyoLnnFj57WpaTUOKX68cfOFXQQxUaLxkebNeUG5hhjUeUYX1V0XGJJdJAPcIdtBZiPM+kqrEB+nlT/Qe56mS75eW902/cnvfH/bEbJPkl9Wp szymonignaczak@EspeoSoftwares-MacBook-Pro.local"
$addkey srogowicz       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiMzU87Gk12bzNCz20HALl+qnNNa8ontKJdYooAJxt+5oiBZFBziBCfRmzBpKReJuf+oo4/gIDF/urBA6zX3XaIpUS5TDiiv/1blq6UQVE6jaoT7atANkeSuAEoMWhhl+AHyoqF6Cw3fmleuA9OKdY1CU0Fjw4IdJGv3AgmnR32xnaiWgXxkbj6UfgMgO6X2z/VCkKPqrf8xK8nrF2XfjCIr3Mbb1/SojNlgW0KRQfDKls+SVlJwlW+Fu8YQngJ0d+PXUgKciYYdVRCYHH4qxGriMpx4q1OCDryIMlhV7m1O9wrvjScp3ztUT9+MPsOQ3EyEhYwtUro6l2NpJCi/id sylwiarogowicz@Sylwias-MacBook-Pro.local"
$addkey srogowicz       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+iHl0kmiX/CnKncrgkLiS3CGG4tRoyG8aQsSwy+V834PeAu3pZGnn7KYlXGagnTZjH17xEQG7AsZI1NTn8Jsdnre0fXfTMFwjdlufNxY7Fnw7S2Zma3WYtxm0u7ycrElvvCEGj3I0DnpZM90bm6NrSiqW2vgXetDGUUUkn5NLd0vlG4Y7K+x+MSg5Atjrw2C1Ve1CdLMQmPpEjUW3q60vB7f9Iuz77uurxqceCMf+HeGeScA7hdo/dbjvqx9npN4QLDjatALWckS9ZVnIBMCQgRnEpAibaEO15ahe0BURfeW+BLvML9KWCW/wJBOld+VCt4rHEa2lkO5QucFGlYPj sylwiarogowicz@Sylwias-MacBook-Pro.local"
$addkey srogowicz       inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEdIUcqg4LhE0WMPnDXYMKGhgy69q5NJGULj3OS+bm5B9zsFVOMOkpq7j8PRNWZA8uOM8+t6i1RxHqpR6KdS6OfBlMaQ7BIHWWUuiOjJJyfWm5uJFh5Y1Y1GVHFVMz7ObnFIe5jd9iva7Yb4JYkQKHiqAWZSDxFuj2KfKLH4B/5hV8oi6XaIAL6QsS2bzlpr6S7IMEJAFOyrGL3tH6MhHcI+3eKPj/Xgq4LLEjge+PEus1obZxeblhmEM35HMFJZDOnYv14aMLp61Pnoct3VXCRHRKFlN46HU1ops3d+x8h6xpKn8CBvdR+OAtQE7x0DbEdTmF0fSF5uViaoNyCZ1v root@Sylwias-MacBook-Pro.local"
$addkey tcichowicz      inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqEzDU3aYFy6MbgDp2Bcq1I1yYRt0IIVgmUqx3TOKvsaSfnDLoL/v7x8KcpI1jtO0BGDH92GhyjI9JD+FN17Oq+Hpe9eFGpesn3xFG+ROnWqmQD6in3RaMSKYYNGnp2J+Vb9HMOHJ6JTnnCwtPpV6D26stElw84L4MSmBvcHm+yybUgMZ0zUQFeBRNZ45Sn2jg7UXkw/OAfouwyw07Dr81Kcar6eePKXkJldyFobq6j3V8M5OBLhubWoUcSdLX6WN0RQSnnRoGHDVrfu6WqtXJ8YV2XNc28wMSEEOXgavKUT2bLuJ4HIiNStER0o683CgUwAcEhYerg3PCWyXxQxZj tcichowicz@tc-mbp"                                                                                                                                                                                                                                                                                                                                                         
$addkey tklim           inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtsKgCD7DHpKYBepegka/3clyVVxz9Ihu54fY6zx4Qnmzo1GB+1PReUfEPMXx33KAe6boJB/HmrT51I1LhQCc7FhHyRjFcM5rjA/nMYf5XrZNBRJYVFOudM/YD1XBETkzWcZjWjJVPKXONGklMxN31jkklThPvg4zCS4I4MTOZWcLTt6XiVtnyToo6DD8T6R86QUf8HDlaEnpyvEqpHMhvSZRjhYDsd9LV/P6cXYsTvNDzMrQbMobkpNfln4Pq+1b482UH6RZp0yurtczlwgHVZBlYAkV4AZoj+VpUnmR3teZiGCB/osdKp6NiwdfofySbbHjXbMb2SN15ljXLmyTP root@tklim-Lenovo-G510"
$addkey ttomalak        inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVRTIyF5WT1XkBSWxoRHo2Qo95ZPCH7t6Rpg0ziuionSRjM8IgGfjJVBBaRmTnY2c/+/OliO+Nr6hqhGt+YM6DZ5dZCBwEptU51M43VUhKBFQQQ6ee/Osi8o5xMszy8/Quxd8HSL0Wd5dh7wXp46gvLVwiEmvaSKheVhLaQPauDTWIiU8au2xqRcY1x+f/c17meZ76vMhV2D1YIuMvSNLHTW+tTutEsH+XHPSDCCnAS9hKQ+fEsirG2kG8bbwrh155RbnDNTh6nEXkQfQNawu44cX5xpTJy5+PXJEn6CK0r7Ojzj1j3QDd4ChSYmIFkzZ/O48JznetJZ1ob0+gvCQ1 tomasz.tomalak@espeo.eu"
$addkey twysocki        inline "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuOp1rdAefeKW1Xh6fCl15iWx1cZlDrhpEHbXpeGl7VAuzg6DpnNZBb+AKN4ZcakQVJQdpckjvquuY78VYsFA1Zp1+dFkh1oTp/wvdf+XNKzmohe7WNVe1bZEpSdEiHEq10s5+5j5sJ/Lhp07kHS1xc56R2GmiOo0sxiwSY97r1gsRC3BXeTiRwRxRI7n7SXDde1t26Ou91rBHTlgASNILytCI3ukE8VKgAcfFTZhajHolecPVtNKhPjcSkfot35UhInPlAPVB8BLGJ20oVLAo6Y8BdPFMmd+Iwuyz61wZteKDg1WLJj8r6SoSDU+S3YgSiSOrEBNWv2KQXmNJd0J7BD2gJDc4CK2MSM58KfAamj7Inf/qCRLcRhpN87X5K8A+NW2H6ATSKF+Ls5TL2Ep4LxMq26nib0w80J/frABMxfHkp9Dv0LlYBKqXG/Ifj0K+2wXsC8kVaDzlLT2SKCE77LgidZKCljbTXnWB1IH6Pe7IEHREG0tJRV7O5DP/2hWDFQRzJCxZtqN3ZX9+gFD4Z1tvndaeHviCPAg9gEaVfp6Th+fFO73UoJo3+23q/cXALB9wevksL+UR5COpiCgTFIulOf0ulL5pCXuZSRuWR5R2EQZlrsdaZ/2bTWkIfyAqiO/Iz4uAWj7lOwncMtbYRU7jV6iGR9OfeYbgsavvzw== tomasz.wysocki@espeo.eu"


/opt/farm/scripts/setup/extension.sh sf-mc-black
/opt/farm/scripts/setup/extension.sh sf-db-tools
/opt/farm/scripts/setup/extension.sh sf-app-deploy
/opt/farm/scripts/setup/extension.sh sf-circle


if [ "$OSVER" = "ubuntu-trusty" ] || [ "$OSVER" = "ubuntu-xenial" ] || [ "$OSVER" = "ubuntu-bionic" ]; then
	dt=`date +"%Y.%m.%d %H:%M:%S"`
	echo "configuring /etc/sudoers.d/espeo file"
	echo "# Espeo Software custom sudoers list, last generated at $dt
%espeoadm ALL=(root) NOPASSWD: ALL
" >/etc/sudoers.d/espeo
fi
