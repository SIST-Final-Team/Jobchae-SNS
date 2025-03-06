package com.spring.app.follow.domain;

import java.util.Date;

import jakarta.persistence.*;

@Entity
@Table(name = "tbl_follow", uniqueConstraints = { @UniqueConstraint(columnNames = { "follower_id", "following_id" }) // follower_id와 following_id는 서로 유니크 관계이므로 중복 팔로우를 방지한다. 
})


public class FollowEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 기본 키 생성 전략
	@Column(name = "follow_id")
	private String followId;

	@Column(name = "follower_id", nullable = false, length = 20)
	private String followerId; // 팔로우 하는 사람 (FK)

	@Column(name = "following_id", nullable = false, length = 20)
	private String followingId; // 팔로우 당하는 사람 (FK)

	@Column(name = "follow_register_date", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date followRegisterDate = new Date(); // 기본값 sysdate 설정

  // 기본 생성자
	public FollowEntity() {
	}

  // 생성자 (팔로워, 팔로잉, 등록일자)
	public FollowEntity(String followerId, String followingId) {
		this.followerId = followerId;
		this.followingId = followingId;
		this.followRegisterDate = new Date(); // 기본적으로 현재 날짜
	}

 // Getter, Setter
	public String getFollowId() {
		return followId;
	}

	public void setFollowId(String followId) {
		this.followId = followId;
	}

	public String getFollowerId() {
		return followerId;
	}

	public void setFollowerId(String followerId) {
		this.followerId = followerId;
	}

	public String getFollowingId() {
		return followingId;
	}

	public void setFollowingId(String followingId) {
		this.followingId = followingId;
	}

	public Date getFollowRegisterDate() {
		return followRegisterDate;
	}

	public void setFollowRegisterDate(Date followRegisterDate) {
		this.followRegisterDate = followRegisterDate;
	}

	@Override
	public String toString() {
		return "FollowEntity{" + "followId=" + followId + ", followerId='" + followerId + '\'' + ", followingId='"
				+ followingId + '\'' + ", followRegisterDate=" + followRegisterDate + '}';
	}
}
